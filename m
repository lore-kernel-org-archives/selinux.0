Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3UCwfJO021862
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 08:58:41 -0400
Message-ID: <5360F37F.2050908@redhat.com>
Date: Wed, 30 Apr 2014 08:58:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>,
 Eric Paris <eparis@parisplace.org>
Subject: Re: selinux_check_access() and unknown classes/perms
References: <CACLa4pvP9mjjGvQ+SkyoorYZAAdxAHMy3maK8rmkbJRMa6JQPA@mail.gmail.com>
 <CAB9W1A0RHSS3VJcbvCtMDULm6zi3xiuN9eBpS49cR6CEoBw0jQ@mail.gmail.com>
In-Reply-To: <CAB9W1A0RHSS3VJcbvCtMDULm6zi3xiuN9eBpS49cR6CEoBw0jQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I would think an AVC entry for an undefined class would be a good idea.
On 04/29/2014 08:02 PM, Stephen Smalley wrote:
> Well, you could use a static variable ala printk_once in the kernel;
> would only happen once per program rather than once per unique denial,
> but there is no real way to do that short of introducing an AVC entry
> for an undefined class...
>
> On Tue, Apr 29, 2014 at 2:14 PM, Eric Paris <eparis@parisplace.org> wrote:
>> selinux_check_access() has code like this:
>>
>>        sclass = string_to_security_class(class);
>>        if (sclass == 0) {
>>                rc = errno;
>>                if (security_deny_unknown() == 0)
>>                        return 0;
>>                errno = rc;
>>                return -1;
>>        }
>>
>> My problem with the code is that we have no logging of any kind why we
>> just returned -1;  The reason this was found is because Dominick is
>> writing custom policy that doesn't define all of the classes/perms
>> used by systemd and has security_deny_unknown() == 1.  systemd calls
>> selinux_check_access() gets -EINVAL, prints that it denied, but no
>> where do we have a good reason why it was denied.  systemd doesn't
>> know, it's hidden in this library...
>>
>> A good first step would be to call avc_log(SELINUX_ERR, ...) in the
>> case where we return an error.  But what do we do in the
>> security_deny_unknown() == 0 case?  I'd still like to call avc_log,
>> but only do it once rather than flood our logs.  Any suggestions how
>> to pull that off?
>>
>> -Eric
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
