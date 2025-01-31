# from app import app
# import unittest


# class FlaskrTestCase(unittest.TestCase):

#     # Set up the test client
#     def setUp(self):
#         self.app = app.test_client()  # Create a test client
#         self.app.testing = True  # Enable testing mode

#     # Test the '/' route
#     def test_hello(self):
#         response = self.app.get('/')  # Make a GET request to '/'
#         self.assertEqual(response.status_code, 200)  # Check if the response is 200 OK
#         self.assertEqual(response.data.decode(), 'Hello, World')  # Check if the response content is 'Hello , World'

# if __name__ == '__main__':
#     unittest.main()


import pytest
from app import app

# Set up the test client


@pytest.fixture
def client():
    app.testing = True  # Enable testing mode
    with app.test_client() as client:
        yield client

# Test the '/' route


def test_hello(client):
    response = client.get('/')  # Make a GET request to '/'
    assert response.status_code == 200  # Check if the response is 200 OK
    assert response.data.decode() == 'Hello, World'  # Check if the response content is 'Hello, World'
