Message-ID: <1129.192.168.1.12.1011589591.squirrel@mail.outstep.com>
Date: Mon, 21 Jan 2002 00:06:31 -0500 (EST)
Subject: restricted guest domain accounts
From: "Lonnie Cumberland" <lonnie@outstep.com>
To: <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

I hope that you are all doing well today.

Some time ago, I was asking about locking users to their home
directory but have recently been thinking that may not be completely
required for our project.

As such, I have been looking at MANY method and various Operating
Systems such as OpenBSD, and the like  for possible solutions to this
original delima.

If I now go along the lines that I will not isolate the users to
their home directories but instead use the most secure OS for the job
then I once again arrive back at SELinux which I am starting to like
more and more.

That being said, I have now gotten SELinux up and running on a
freshly installed Redhat 7.2 server.

What I am not looking to do is to humbly ask for some help from the
list to create a guest domain so that I can add new users to and they
will have very restricted abilities on the server. A simple example
would be great if someone might have one to share with me.

I have also printed out the documentation on the website and am now
reading over it to try and get a feel for how I can do things.

I will next be installing OpenOffice/StarOffice on my SELinux server
but would like not to allow the guest domain users to run many of the
existing applications that are in the "/bin /sbin /usr/bin ...."
directories.

Perhaps only allow them to run just a few that I will decide upon.

It appears that SELinux can easily be set up for such thing and I
hope that someone will please help to guide me through these initial
difficult learning times.

Best Regards,
Lonnie

-- 
 Lonnie Cumberland
 OutStep Technologies Incorporated
 (313) 832-7366

 URL: http://www.outstep.com
 EMAIL: Lonnie@OutStep.com
      : Lonnie_Cumberland@yahoo.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
