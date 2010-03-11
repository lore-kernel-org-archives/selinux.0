Subject: Re: how to cope with file renames?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20100311081913.GC24034@myhost.felk.cvut.cz>
References: <20100311081913.GC24034@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Thu, 11 Mar 2010 08:46:58 -0500
Message-Id: <1268315218.16780.10.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-11 at 09:19 +0100, Michal Svoboda wrote:
> Hello,
> 
> I'm struggling with the problem seemingly as old as filesystems - if you
> rename() a file, it retains all its permissions, incl. the context,
> because its inode stays the same.
> 
> My particular problem is moving stuff from /tmp using PHP's
> move_uploaded_file function. I'm aware of the copy/delete workaround,
> but that just isn't the same (performance, atomicity, etc.) Also there
> is the way of post-relabeling the moved file but that requires more
> permissions plus there are no selinux bindings in PHP that i'm aware of.

http://pecl.php.net/package/selinux

> In short, I was wondering if there was a way for a rename()d file to be
> subjected to a type transition as if a new file was created? (I tried a
> type_trans rule but to no avail.) Or any other way to deal with renaming
> files between variously contexted dirs?

No.  The best way of course is to create the file with the right
security context in the first place, whether explicitly or by uploading
it to the same parent directory as the final destination.  Alternatively
the php scriptlet can use the selinux bindings to manipulate the
context, or you can configure restorecond(8) to watch for the
destination file and reset its security context as needed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
