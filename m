Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAFDdtvc021658
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 08:39:55 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAFDdCw8028569
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 13:39:12 GMT
Message-ID: <455B18AE.6050901@redhat.com>
Date: Wed, 15 Nov 2006 08:39:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest Diffs
References: <453E2A8C.4070207@redhat.com> <1162328409.31675.131.camel@sgc.columbia.tresys.com> <455A2304.5090709@redhat.com> <200611152049.38615.russell@coker.com.au>
In-Reply-To: <200611152049.38615.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Wednesday 15 November 2006 07:11, Daniel J Walsh <dwalsh@redhat.com> wrote:
>   
>>>> Redhat's Fedora Extras apd-get and apt-shell run as rpm.
>>>>         
>>> Can't add this because it causes conflicting file contexts if the dpkg
>>> module is included.
>>>       
>> I think we need a rewrite of the dpkg te file so on redhat platforms
>> dbkg_t is aliased to rpm_t.
>>     
>
> I think it's best if Red Hat compiles just don't include dpkg.te.
>
> Have apt-get and yum run in the same context in Fedora.
>
>   
That is the way it is now, but it is unacceptable to upstream.  Chris 
does not like the conflicting
file context.
>>>> squid wants to rw_tmpfs for diskd mode.
>>>>         
>>> I'm wondering if this is tmpfs_t because there is no squid_tmpfs_t+type
>>> transition, or if it is because the machine is targeted.
>>>       
>> Not sure, this was in the old policy as well.  Never used squid.
>>     
>
> I believe that it was a mistake in the Squid policy.
>
>   
I have just recently received an AVC requiring it, which is why I put it 
back.
>> Added boolean to allow daemons to dump core in /.
>>     
>
> Some of the fun things this permits include:
>
> Creating a file named /fsckoptions with "-r" or "-N" as the contents (system 
> hang on boot or failure to ever do an automatic fsck).
>
> Creating /.unconfigured (could be good for taking over an Internet terminal 
> machine).
>
> Also as daemons don't have separate types for the core files there is the 
> issue of matching the core files up to the domain that generated them.
>
> Can't you use /proc/sys/kernel/core_pattern to put the core files somewhere 
> else?  Preferably somewhere in a mode 700 directory.
>
> Also those files that are generated in the root directory are a bad idea, 
> there should probably be a long term plan to move them elsewhere.
>
>   
I am looking into this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
