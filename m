Message-ID: <489861A3.5010505@redhat.com>
Date: Tue, 05 Aug 2008 10:20:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils patch
References: <4892F6E0.10008@redhat.com> <1217943844.2994.65.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217943844.2994.65.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-08-01 at 07:43 -0400, Daniel J Walsh wrote:
> Adds support for boolean files, name/value pairs as input and output.
> Allows you to set a large amount of booleans at once.
> 
> Add support from groupname in semanage login.  This will allow you to
> associate groups of Linux Users with an SELinux user.  Uses same syntax
> as sudo.  Requires patch to libselinux.
> 
> Cleanup of semanage variables.  Change use of 1/0 to True/False.
> 
> Remove bad use of raise(out)
> 
>> Looks ok other than adding gui to the Makefile since we don't have that
>> one.  But upon trying "semanage login -a -s root %wheel", I get:
>> libsemanage.get_users: user %wheel not in password file
> 
>> So it seems that we also need libsemanage to understand the %groupname
>> syntax?  That is coming from genhomedircon.c.
> 
>> If actually supporting per-role file labeling, then we'd need
>> libsemanage to expand the group and add the individual users for
>> generating home directory entries.
> 
> 
Yet another reason to remove the atrocity that is per role labeling.
Changing the default role of a user or group of users should not involve
the relabeling of a potentially huge amount of files, never mind that
you can't fix /tmp files.  Stop the insanity...

Then we have the problem of shared homedirs where you have different
roles on different machines, and potentially can log in to the same
machine with different roles depending on how you login.  guest_r if you
login via ssh but staff_r via the console.

Someday I will win this battle...



--SNIP--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
