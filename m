Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AJ8xrT000262
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 15:08:59 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AJ8uaH019891
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 15:08:56 -0400 (EDT)
Subject: Re: Restrict File creation types
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kenny <selinux@kfk2.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040610172612.25551.qmail@web.different1.com>
References: <20040610172612.25551.qmail@web.different1.com>
Content-Type: text/plain
Message-Id: <1086894527.4397.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Jun 2004 15:08:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-06-10 at 13:26, Kenny wrote:
> How would I go about restricting all files created in a certain
> directory to a set of types. Eg:
> I have Dir Types:
> Dir_Type1_t
> Dir_Type2_t
> and file Types:
> File_type_1a_t
> File_type_1b_t
> File_type_2a_t
> File_type_2b_t
> 
> I want all files in Dir_Type1_t to be of types File_type_1a_t or
> File_type_1b_t no matter the domain of the creating process 
> and all files in Dir_Type2_t to be of types File_type_2a_t or
> File_type_2b_t.
> (mkdir -Z user:object_r:File_type_2a_t TEST in a dir of type
> Dir_Type2_t should fail as any user/role/domain)
> 
> I've tried looking through the logs with auditallow on for all the Dir
> and File types, but didn't see anything where both types where listed
> in the same allow statement.  Is this even possible?

There isn't a particular permission that enforces an association between
the parent directory type and the new file type.  You can do things
like:
- Prevent a domain from specifying a particular context at all for a new
file, forcing new files to inherit from the parent directory or to
follow any type_transition rule specified in the policy.
- Control which domains can write to a given directory, and then ensure
that those domains can only create files with particular types.

It wouldn't be difficult to add a new permission check between the
parent directory type and the new file type on file creation, but you
would also need to ensure that the property is preserved for hard links,
and possibly for bind mounts.

There is a permission check performed between the new file type and the
filesystem type.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
