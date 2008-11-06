Subject: Re: Restorecond.conf
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <B566A9B5-2746-4A0F-8E0C-07361FA300CE@gmail.com>
References: <B566A9B5-2746-4A0F-8E0C-07361FA300CE@gmail.com>
Content-Type: text/plain
Date: Thu, 06 Nov 2008 14:10:17 -0500
Message-Id: <1225998617.814.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-11-06 at 11:03 -0800, Justin P. Mattock wrote:
> I'm seeing a fail during boot,
> Not sure if this is restorecond or not.
> When looking at restorecond.conf
> /etc/samba/secrets.tdb is at
> /var/lib/samba/secrets.tdb
> 
> ~/public_html doesn't exist
> 
> ~/.mozilla/plugins/libflashplayer.so
> is at
> /usr/lib/flashplugin-nonfree/libflashplayer.so
> 
> Does it hurt to just change the loaction in restorecond.conf or should
> I configure these apps to use these files?

If you use restorecond (which is optional), then you would normally
modify restorecond.conf to match your system, not the other way around.
And only for files that are likely to get re-created at runtime in a way
that won't preserve their security contexts already (either by virtue of
a type transition rule based on creating domain and parent directory
type or by virtue of explicit application support for preserving
contexts).  

So for example,
/usr/lib/flashplugin-nonfree/libflashplayer.so
is likely already labeled correctly at install time based on your
file_contexts configuration and doesn't require anything in
restorecond.conf, whereas if you locally install a
~/.mozilla/plugins/libflashplayer.so
it likely wouldn't have the right context by default.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
