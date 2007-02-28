Subject: Re: refpolicy modules
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vin@netwosix.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1172669862.5757.10.camel@localhost>
References: <1172654815.7570.7.camel@localhost>
	 <1172667937.19041.458.camel@moss-spartans.epoch.ncsc.mil>
	 <1172669862.5757.10.camel@localhost>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 09:00:22 -0500
Message-Id: <1172671222.11157.52.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-28 at 14:37 +0100, Vincenzo Ciaglia wrote:
> On mer, 2007-02-28 at 08:05 -0500, Stephen Smalley wrote: 
> > What are you asking?  You should be able to turn off modules that you
> > don't need and have the rest build, although there likely is a
> > fundamental core set of modules that are presumed to be present.  If you
> > have specific cases where you disabled a module and couldn't build the
> > rest of the policy, then report those.
> 
> Well maybe it's better to give you an example, here the modules that i
> want to run on Netwosix for now: 
> http://www.netwosix.org/selinux/modules.conf
> 
> Then when i try to "make install" i get some errors related to other
> modules evidently needed by the modules in my .conf. Here the example:
> 
> ##################################
> /usr/bin/checkmodule:  loading policy configuration from tmp/apache.tmp
> policy/modules/services/apache.te:239:ERROR 'syntax error' at token
> 'avahi_stream_connect' on line 14780:
>                 avahi_stream_connect(httpd_t)
> #line 239
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make: *** [tmp/apache.mod] Error 1
> ##################################
> 
> Of course this happen because i'm not using the avahi module. To solve
> this i just have to comment the line related to "avahi" in my
> policy.conf. What i'm asking for is a way to don't edit and wast so many
> time by editing each line of my policy.
> 
> For example if my apache.te depends to "avahi" and avahi is not present
> in my strict-policy with its module, the policy should understand this
> and skip this step by compiling the whole policy just using the modules
> that are present.

It looks like you deleted the avahi module source files rather than just
turning it off in modules.conf.  The source files are still required to
compile the modules that depend on avahi (optionally or otherwise).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
