From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Fwd: "star -xattr" in SELinux enabled system
Date: Sun, 10 Jun 2007 12:38:08 +1000
Cc: SELinux@tycho.nsa.gov
References: <292705.1594.qm@web53706.mail.re2.yahoo.com> <200706101225.45161.russell@coker.com.au>
In-Reply-To: <200706101225.45161.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706101238.11820.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 10 June 2007 12:25, Russell Coker <russell@coker.com.au> wrote:
> There has been at least one report of a kernel exploit not working as
> unconfined_t! 

http://www.redhat.com/archives/fedora-selinux-list/2006-July/msg00071.html

Above is the reference to an exploit stopped by targeted policy.  It doesn't 
mean much as a.out support (not provided by default in any of the tested 
distributions) is required for the exploit.  So the people who tested this 
had to go out of their way to make their machine vulnerable to see that SE 
Linux protected it.  But it does suggest that the same thing could happen 
again.

It has been mentioned on this before, but it's worth mentioning again.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
