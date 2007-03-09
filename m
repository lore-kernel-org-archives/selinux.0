Subject: Re: mmap_file_perms needs ioctl also
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200703091838.26634.russell@coker.com.au>
References: <45F02B61.7040008@redhat.com>
	 <200703091838.26634.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 07:51:29 -0500
Message-Id: <1173444689.3241.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-09 at 18:38 +1100, Russell Coker wrote:
> Why?
> 
> Many programs that mmap files will also make ioctl() calls on them.  But AFAIK 
> there is nothing forcing the application programmer to do so.  Expanding the 
> permissions in this regard seems unnecessary.

ioctl permission is effectively useless as it doesn't distinguish
read-flow vs. write-flow vs. control-op, so it ends up being allowed
pervasively whenever you allow read or write.  We really need to just
replace it (ala the attempts by Lorenzo in the past), but doing so
compatibly won't be easy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
