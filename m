Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v938YESD013476
 for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2017 04:34:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67E3381233
 for <selinux@tycho.nsa.gov>; Tue,  3 Oct 2017 08:33:39 +0000 (UTC)
To: selinux@tycho.nsa.gov
References: <CAENH-vA_rbUf8UyDcGmCto3-R9zNPy1jMMoH+XKwRqx7c4P-qQ@mail.gmail.com>
 <20170802163500.GA16782@julius.enp8s0.d30>
 <1501700374.3000.15.camel@tycho.nsa.gov>
 <20170802190137.GA10043@julius.enp8s0.d30>
Cc: Joe Orton <jorton@redhat.com>
From: Lukas Vrabec <lvrabec@redhat.com>
Message-ID: <9be86028-d01e-361b-ee0b-115657189ea4@redhat.com>
Date: Tue, 3 Oct 2017 10:33:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170802190137.GA10043@julius.enp8s0.d30>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: Re: httpd_graceful_shutdown makes httpd_can_network_connect
 mostly mute
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/02/2017 09:01 PM, Dominick Grift wrote:
> On Wed, Aug 02, 2017 at 02:59:34PM -0400, Stephen Smalley wrote:
>> On Wed, 2017-08-02 at 18:35 +0200, Dominick Grift wrote:
>>> On Wed, Aug 02, 2017 at 04:41:00PM +0100, Carlos Rodrigues wrote:
>>>> Hi,
>>>>
>>>> I don't know if this a too basic question to ask here, or the
>>>> proper
>>>> place, but here it goes:
>>>>
>>>> I've been chasing some weird (to me) behavior with the targeted
>>>> policy
>>>> on a VM running nginx as a reverse proxy. What happens is that the
>>>> "httpd_can_network_connect" boolean needs to be enabled for nginx
>>>> to
>>>> be able to reach its upstream servers. So far, so good.
>>>>
>>>> However, if the upsteam server happens to be listening in one of
>>>> the
>>>> "http_port_t" ports, "httpd_can_network_connect" isn't needed
>>>> because
>>>> the "httpd_graceful_shutdown" (default enabled) provides the
>>>> required
>>>> allow rule ("name_connect").
>>>>
>>>> This seems strange to me. Is this supposed to be like this? I would
>>>> expect nginx to be totally unable to establish outbound connections
>>>> by
>>>> default.
>>>>
>>>> Best regards,
>>>>
>>>> Carlos Rodrigues
>>>>
>>>> PS: I just spent a few hours on this, wondering why one machine
>>>> needed
>>>> "httpd_can_network_connect" and another did not. I guess I've
>>>> mostly
>>>> been setting up reverse proxies for "http_port_t" upstreams on
>>>> CentOS
>>>> all this time...
>>>
>>> I think the "httpd_graceful_shutdown" is an apache thing (probably
>>> for "apachectl graceful-stop"). However I cannot reproduce this
>>> behavior with httpd-2.4.27-4.fc27.
>>
>> Hmm...neither can I; seemingly apachectl graceful-stop works without
>> requiring this boolean anymore.  So maybe it can be disabled by default
>> and removed at some point in Fedora policy?
>>
> 
> Would be nice if we would be able to confirm this with the apache maintainer before jumping to conclusions.
> 

I had a discussion with apache maintainer in Fedora and he confirmed 
that this boolean is no longer needed in Fedora 27 or higher. Adding him 
to CC.

I see that in refpolicy, default value of httpd_graceful_shutdown is 
off, so we need to fix it only in Fedora distro policy. I'll prepare the 
patch.

Lukas.

-- 
Lukas Vrabec
Software Engineer, Security Technologies
Red Hat, Inc.
