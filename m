Message-ID: <425C19E5.5000402@redhat.com>
Date: Tue, 12 Apr 2005 14:56:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Strict policy gettting stricter.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have turned off user_can_mount, unlimitedRC and unlimitedUtils 
tunables in selinux-policy-strict-1.23.10-2.

As targeted policy gets more targets, it is time to make stricter policy 
stricter (at least for Fedora and RHEL).

user_canbe_admin is the next target, as soon as we get the ability to 
manipulate roles from libsepol/libselinux.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
