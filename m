Message-ID: <558871A4.60107@redhat.com>
Date: Mon, 22 Jun 2015 22:35:48 +0200
From: Miroslav Grepl <mgrepl@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Strange behavior: type boundaries
References: <20150313181459.GB9437@linksys-wireless-usb.network2>
 <55032BCD.7090103@tycho.nsa.gov>
 <20150313184330.GC9437@linksys-wireless-usb.network2>
 <55033162.8040508@tycho.nsa.gov>
 <20150314072253.GA26393@linksys-wireless-usb.network2>
 <5506CFD9.2030606@tycho.nsa.gov> <558832B8.8020705@redhat.com>
 <20150622180857.GB10451@localhost.localdomain>
 <5588513C.2050309@tycho.nsa.gov>
In-Reply-To: <5588513C.2050309@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/22/2015 08:17 PM, Stephen Smalley wrote:
> On 06/22/2015 02:08 PM, Dominick Grift wrote:
>> On Mon, Jun 22, 2015 at 06:07:20PM +0200, Miroslav Grepl wrote:
>>
>>>
>>> In Fedora, we have unconfined_service_t domain for unconfined services
>>> started by init. So there is init_t @bin_t -> unconfined_service_t and
>>> we get op=security_bounded_transition for init_t against
>>> unconfined_service_t. But of course it is not going to work with
>>>
>>> typebounds init_t unconfined_service_t;
>>>
>>> because there is
>>>
>>> # <audit-1401> op=security_compute_av reason=bounds
>>> scontext=system_u:system_r:unconfined_service_t:s0
>>> tcontext=system_u:object_r:bin_t:s0 tclass=file perms=entrypoint
>>>
>>> So this logic breaks our concept with unconfined_service_t.
>>>
>>
>> What is running in the unconfined_service_t domain in that event?
> 
> Nothing at the point of that message.  The message indicates a bounds
> failure, which will then cause the kernel to fall back to the old
> context if it was an automatic transition, or fail the exec with -EPERM
> if it was explicitly requested via setexeccon().
> 

Please, forget about it. It works as expected. Sorry for the noise.
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
