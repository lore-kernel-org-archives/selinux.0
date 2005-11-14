Subject: Re: Running programs from a PHP script under SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Simon Gornall <simon@gornall.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <840CEAA7-85D1-4C5B-8B8D-B8E55AB217A7@gornall.net>
References: <840CEAA7-85D1-4C5B-8B8D-B8E55AB217A7@gornall.net>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 10:10:45 -0500
Message-Id: <1131981045.5415.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-11-13 at 11:24 -0800, Simon Gornall wrote:
> This is very much a newbie question I'm afraid - if there's a more- 
> appropriate forum, I'll be glad to be pointed in their general  
> direction :-) I can't see anything in the FAQ (though I guess I may  
> not have recognised the solution) or after having googled...

Just FYI, some other information resources about SELinux are listed in
http://selinux.sourceforge.net/resources.php3

> When  I call 'exec("/path/to/program") from within a PHP script, it  
> does actually work, but I get a message in the 'dmesg' output like:
> 
> audit(1131753033.872:49): avc:  denied  { execute } for  pid=15678  
> comm="fortune" name="ld.so.cache" dev=md2 ino=132328  
> scontext=root:system_r:httpd_sys_script_t  
> tcontext=root:object_r:ld_so_cache_t tclass=file

What does execstack -q `which fortune` show?  Typically, that audit
message suggests that kernel is translating PROT_READ requests by that
binary to PROT_READ|PROT_EXECUTE in order to provide compatibility with
"legacy" binaries that presumed read-implies-exec logic.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
