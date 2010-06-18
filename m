Subject: Re: Benchmarking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Otheim <coriolis220@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <AANLkTik72PznqNvcz_2mp9kwTjdGA2NiTLo7v0yv2i47@mail.gmail.com>
References: <AANLkTik72PznqNvcz_2mp9kwTjdGA2NiTLo7v0yv2i47@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Jun 2010 09:47:34 -0400
Message-ID: <1276868854.22449.30.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-06-17 at 20:49 -0400, Paul Otheim wrote:
> Most of the benchmarking figures I have seen or heard of consistently
> say that, depending on what your doing, the average performance hit
> when running SELinux is about 5 to 7 percent. My question is if anyone
> has benchmarked with no DAC and SELinux only for permissions checks.
> What, if any, is the performance gain? Can I get that seven percent
> back? I know its not a strict SELinux question but I don't know of any
> other place to ask such a thing. 

There isn't any way to disable DAC checking in the kernel.

The /selinux/avc files may be helpful in examining and adjusting the
behavior of the Access Vector Cache (AVC), which was designed to
minimize the performance overhead of SELinux.  See:
http://james-morris.livejournal.com/2153.html
http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/selinux-guide/rhlcommon-section-0102.html


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
