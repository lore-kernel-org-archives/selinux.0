Message-ID: <3F57A7FA.8050806@diyab.net>
Date: Thu, 04 Sep 2003 17:00:42 -0400
From: Diyab <diyab@diyab.net>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: max barwell <maxb@paradise.net.nz>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: libselinux.so: cannot open shared object file
References: <1062637188.565.7.camel@orac.lite.net.nz> <1062690102.15712.16.camel@columbia>
In-Reply-To: <1062690102.15712.16.camel@columbia>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:
> On Wed, 2003-09-03 at 20:59, max barwell wrote:
> 
>>I am using debian sid, I compiled a 2.6.0-test4 kernel ready for use,
>>and downloaded Colin Walters SElinux packages, during their install, and
>>I'm not sure when as I wasn't watching, the install borked, and now when
>>I try to do anything ie type ls, I get the error message
>>
>>error while loading shared libraries: libselinux.so: cannot open shared
>>object file: No such file or directory 
> 
> 
> Hm, for some reason the binaries are getting linked against
> libselinux.so instead of libselinux.so.1.  I'll investigate this.  In
> the meantime it should be sufficient to install libselinux1-dev. 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> .
> 

Why not just link libselinux.so to libselinux.so.1 ?  That would at 
least temporarily fix the problem would it not?

Timothy,

-- 
I put instant coffee in a microwave and almost went back in time.
		-- Steven Wright


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
