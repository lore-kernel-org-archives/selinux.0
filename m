Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9EHNcWt019973
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 13:23:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9EHNYmR018075
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 17:23:34 GMT
Received: from ms-smtp-02-eri0.southeast.rr.com (ms-smtp-02.southeast.rr.com [24.93.67.83])
        by jazzband.ncsc.mil  with ESMTP id h9EHNXjp018067 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 17:23:33 GMT
Received: from nc.rr.com (rdu26-59-021.nc.rr.com [66.26.59.21])
	by ms-smtp-02-eri0.southeast.rr.com (8.12.10/8.12.7) with ESMTP id h9EHNQ9j023593
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 13:23:27 -0400 (EDT)
Message-ID: <3F8C310E.5060800@nc.rr.com>
Date: Tue, 14 Oct 2003 13:23:26 -0400
From: Jeff Johnson <n3npq@nc.rr.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: trusted vs untrusted packages
References: <200310141107.53852.russell@coker.com.au> <200310141333.39662.carsten.grohmann@raumbildsysteme.de>
In-Reply-To: <200310141333.39662.carsten.grohmann@raumbildsysteme.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Carsten Grohmann wrote:

>I think the idea of signed rpms is good and useful. 
>
>  
>
>>RPMs can be signed or unsigned.  If an RPM is signed by a trusted
>>organization then there should be some differences in an SE Linux
>>install than if it is not signed or if we don't trust the signer.
>>    
>>
>
>Whom should we trust? The people of the personal web of trust?
>  
>

Defining "trust" is exactly the question. Using fingerprint of package 
signature
to identify "trust" is one, not too surprising, definition for package 
trust.

The deeper issue is factoring trust of package onto trust of contents, both
metadata (which includes scripts to be executed), and payload contents
(i.e. the files themselves).

>  
>
>>One idea is to have signed packages be installed by rpm running
>>as rpm_t and unsigned packages be installed by rpm running as
>>rpm_unsigned_t [1].  So for example we could allow rpm_unsigned_t
>>to install files in /sbin as sbin_unsigned_t and in /bin as
>>bin_unsigned_t [2].  Then a program installed from an untrusted
>>package can't be run from sysadm_t, and if it's run from other
>>trusted domains (EG part of the mail server) then it could
>>trigger an automatic domain transition to an appropriate domain.
>>    
>>
>
>I'm not sure, about this idea. Because it is necessary to patch rpm 
>and the most rpms I've seen creates the file context during the 
>post install squence using chcon. On the other side we have more 
>secure packages with a (little bit) more complex policy. 
>
>What's about debian packages? Would you sign this too and adapt the 
>package tools to handle the file context? 
>
>  
>

I'd suggest looking at a model of a tar archive with a detached 
signature while
developing a trust definition. That model applies to all package management,
and should help clarify the trust model for package management, *.rpm and
*.deb are just archives with certain conventional ornamentation.

73 de Jeff




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
