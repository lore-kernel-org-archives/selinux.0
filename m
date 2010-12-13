Message-ID: <4D067B2F.2050000@manicmethod.com>
Date: Mon, 13 Dec 2010 14:59:43 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Chad Sellers <csellers@tresys.com>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Stephen Lawrence <slawrence@tresys.com>
Subject: Unit testing userspace
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So, we have a few "unit" tests for parts of userspace. I use quotes because many 
of them aren't unit tests at all but tests wrapping around a giant black box 
masquerader as a unit test (e.g., all the linker/expander tests).

Some problems with the current tests are 1) they aren't run by default, 2) they 
use a unit test framework now in yum, 3) they have interdependencies within the 
tree and 4) a lot of the things in the repo are really hard to unit test.

We'd like to spend some cycles here doing unit tests but we need to address the 
above problems first.

The requirements I'd throw out are:

1) Each component (libsepol, libselinux, etc) must be testable outside of the 
main repo (so that tests can be run from rpm, portage, etc)
2) Must not require anything outside of yum
3) Each test should test a single unit (see 
<http://www.javaranch.com/unit-testing.jsp> for an explanation)
4) Must be run in the default build target
5) Be useful tests

For unit tests to be useful they must get run, unfortunately Fedora doesn't seem 
to like to package unit test frameworks so we'd need to put one in the tree and 
use it directly.

We could:

- write our own and put it in the repo
- use a simple single .c file solution like CuTest
- try to get one packaged up in Fedora
- use something more powerful and add it to our repo

All varying levels of bad.

Further, to meet requirement #1 the test framework would have to be duplicated 
once per framework.

Now, to throw more wrenches in the machinery, a huge amount of the libraries 
(particularly libselinux) aren't directly unit testable. They'd need to use a 
framework that can mock functions (eg., to test is_selinux_enabled() you'd need 
to mock the fopen() and read() functions). This makes the more simple solutions 
not as useful.

I've recently worked with a framework called test-dept 
<http://code.google.com/p/test-dept/> that can do mocking and assertion testing. 
It is a pain to use and requires a bunch of headers, Makefiles and a program to 
manipulate the object files to run.

After thinking about this quite a bit I don't know if we can have reasonable 
test coverage without using something capable of mocking. I've also looked at 
other frameworks that provide mocking and they aren't suitable for a variety of 
reasons.

So... this is starting to sound like rambling but the only thing reasonable I 
can come up with (and reasonable is a stretch) is to remove all the CUnit tests, 
start doing unit tests with test-dept, checked in to the test directory of each 
component. We could start with simple tests and eventually graduate to mock 
tests. The reason I'd rather do this than start with something like CuTest and 
move to test-dept when we need its capabilities is because I did that very thing 
on a recent project and the two systems are very incompatible and we now have 2 
completely separate sets of tests and difficulty finding out what is tested and 
where and by what.


Opinions? Compromise? Should we just give up on unit testing altogether?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
