require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "  #Es cadena debe testear invalida por ser blank?
    assert_not @user.valid? #Al ser blank (por esta solo llena de espacios),el modelo reporta FALSE
  end #Y el validador tiene un NOT, que niega ese FALSE para dar TRUE, que es como se pasa el test!

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup   #Se crea un usuario duplicado
    @user.save                   #Se guarda el usuario original en la DB
    assert_not duplicate_user.valid?  #Se solicita validación del duplicate_user (se verifica contra DB)
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
      @user.password = @user.password_confirmation = " " * 6    #Aca hay doble confirmacion de que no esten vacíos
      assert_not @user.valid?
  end

  test "password should have a minimum length" do
      @user.password = @user.password_confirmation = "a" * 5    #Y en esta que sean más de 6 caracteres
      assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
      assert_not @user.authenticated?('')
  end

end
