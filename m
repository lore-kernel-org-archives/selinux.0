Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5FFg0iT022694
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2007 11:42:00 -0400
Received: from web51509.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5FFg0Bo017606
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2007 15:42:00 GMT
Date: Fri, 15 Jun 2007 08:41:54 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: regarding privilege granting
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <20842.17629.qm@web51509.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm not sure I really like the idea of SE Linux getting in the business of
granting permissions. I want to make sure that we have a full discussion about
all aspects of the change. Some of these items I know can be decided by policy,
but I think you will hear things like this when it goes up for wider review. I
want to state them here so that we have answers later.

1) Education. We've been telling users all along that SE Linux does not grant
permissions. It adds restrictions on top of DAC. To change that now would likely
confusion the casual user.

2) Nothing security relavent happens without root. All of the trusted databases
require uid 0 to write to them. In some cases to read. All applications that need
special permissions have been carefully arranged to start as root and drop
capabilities as they can.

3) In the few places where setuid must be used, these programs have undergone
review dozens of times for flaws. No one allows them without much review. If SE
Linux gets into the business of granting privs, then I doubt people would give
the apps the extra amount of review that they should get.

4) Setuid apps are also given special protection by the runtime linker. Without
having the equivalent ability, you are opening the door to attacks in ways that
were probably not imagined.

5) Apps could work when SE Linux is enabled and suddenly malfunction if selinux
is disabled. I could see a case where an app had a certain power and loses it
while its running (depending on what permissive means) and leaves the system in
an unsafe state.

6) What would permissive mode look like? Would any app that wants any capability
automatically get it? If you enforce old capability model then it isn't
permissive since you won't be able to collect all the permissions that an app
needs.

7) It will be hard to find for compliance auditing any applications that have
been granted special privileges.

8) Backdoors can be planted into systems with the aid of selinux policy. People
have no way of comparing what is in memory against what is on disk. Modifying
policy in memory will become an attack point since it now can grant capabilities
instead of impose restrictions. Rootkit detectors will not be able to find this
attack vector.

9) Allowing SE Linux to override DAC restrictions means that we go from 2 layers
of security to 1 layer. All analysis would have to be done from a selinux
perspective. I seriously doubt the average admin will be able to analyze the
security implications on a server given the tools available. You would need to
have commandline tools that lets an admin make some basic discoveries about
access. They will need to be able to find all apps with elevated privileges, what
capabilities does it have. Given a file, what accounts & domain can access or
alter it, given a file and domain what actions can be performed? I think this
will tremendously complicate understanding security for your machine.

10) Simple commandline tools will need to be available for people to remove the
granted capability if they disagree with it. Think about times when people chmod
a program to remove the setuid bit so that it only runs for the admin.

11) What about signal/ptrace attacks. If apps started as a user do not change
uid, the user has control over them. Some operations follow uid rules when the
kernel is deciding whether or not to allow an interaction. If SE Linux elevates
the privs, then the user may have a new way to attack a previously unassailable
target.

There are likely many unforeseen attack vectors that this opens the door to.
There would have to be new analytical tools created to allow people to understand
what they are deploying. This has to be carefully considered by a wider audience
before proceeding.

-Steve


       
____________________________________________________________________________________
Pinpoint customers who are looking for what you sell. 
http://searchmarketing.yahoo.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
