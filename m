Subject: Re: Need Help Compiling Reference Policy on Mobile Device
From: Stephen Smalley <sds@tycho.nsa.gov>
To: waqar afridi <afridi.waqar@gmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTinhRsFY0V-tjXCfsVz2D4kc5AK9MytnBzdh6Qk3@mail.gmail.com>
References: <AANLkTinhRsFY0V-tjXCfsVz2D4kc5AK9MytnBzdh6Qk3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Mar 2011 08:56:38 -0500
Message-ID: <1299160598.16714.6.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-03-03 at 15:28 +0500, waqar afridi wrote:
> Hello All
> 
> Its Me Again, Now I am compiling the Reference Policy on a mobile
> Device (Openmoko), I have also done this Before and that time it was
> successful but Now when I "make load" it, The Following happens
<snip>
> libsemanage.semanage_reload_policy: load_policy returned error code 1.
> (No such file or directory).
> libsemanage.semanage_reload_policy: load_policy returned error code 1.
> (No such file or directory).
> /usr/sbin/semodule:  Failed!
> make: *** [load] Error 1

Looks like you don't have load_policy installed in one of the expected
locations (/sbin or /usr/sbin) and have not otherwise
configured /etc/selinux/semanage.conf to specify a pathname for it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
