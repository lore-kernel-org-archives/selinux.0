Message-ID: <462E0160.8090906@redhat.com>
Date: Tue, 24 Apr 2007 09:08:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Ken YANG <spng.yang@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: can not boot with strict policy
References: <462CA1F0.2000400@gmail.com>	 <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>	 <Line.LNX.4.64.0704231341100.3793@d.namei>	 <1177350508.24282.58.camel@moss-spartans.epoch.ncsc.mil>	 <462CF79C.5080804@redhat.com> <1177417417.8672.25.camel@sgc>
In-Reply-To: <1177417417.8672.25.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2007-04-23 at 14:14 -0400, Daniel J Walsh wrote:
>   
>> So the real question, is there much value with the division between 
>> lib_t and shlib_t.
>> When dealing with strict policy, shared libraries were always getting 
>> mislabeled as lib_t, and causing problems, for little security advantage. 
>>     
>
> In Gentoo I don't see these kinds of problems, and we still have the
> strict policy as the default option (until recently on desktops) and I
> don't see this problem; the fc regexes work very well.  However, the
> Gentoo community is far smaller than Fedora/RHEL.
>
>   
The problems happen when people use tools like cp/tar and other tools to 
put libraries on the system.  So the question I put out is the value of 
being able to stop mmap a non shared library, give you a security 
benefit, versus the hassle of a denial, because of a mislabeled shared 
library.
I look at this the same way as bin_t/sbin_t, it might have made sense 
theoretically but in practice it added little/no security value.
>> As we remove the differences between strict and targeted, I don't intend 
>> to get rid of lib_t == shlib_t.
>>     
>
> I had intended to drop the alias, so i guess we need more discussion. :)
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
