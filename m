Message-ID: <406200DA.4010102@redhat.com>
Date: Wed, 24 Mar 2004 16:42:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: I would like to suggest a new file attribute like usersafe.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One of the things I have thinking about at is the ability to globally 
say a context can read these files.
For instance allowing the slocate policy to read files.  Rather then 
trying to figure out all of the file types
that are safe to read and listing them in policy, if we had a attribute, 
similar to sysadminfile,  that indicated
it was safe for users access we could have a simpler rules.

usersafefile?



So as policy developers decide to add a new context for XYZ app, they 
can add attribute that will allow
users access.

r_dir_file($1_locate_s, usersafefile)


Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
