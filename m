In-Reply-To: <53D2B3ED.2070102@quarksecurity.com>
References: <53D28DBB.8000905@tycho.nsa.gov>
 <53D2B3ED.2070102@quarksecurity.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC] [PATCH] libsemanage: Skip policy module re-link when only
 setting booleans.
From: Russell Coker <russell@coker.com.au>
Date: Tue, 05 Aug 2014 18:30:59 +1000
To: Joshua Brindle <brindle@quarksecurity.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3ba4c81f-8159-46de-82fa-265427d4abc3@email.android.com>
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Would be nice to have a global system setting regarding whether saving disk space is a priority. Then this could be one of many things that could work differently depending on whether the sysadmin wants to save space.

On 26 July 2014 5:45:49 AM AEST, Joshua Brindle <brindle@quarksecurity.com> wrote:
>Stephen Smalley wrote:
>> Motivated by:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1098446
>>
>> I believe this is always safe for booleans because we only set their
>> value; we are never adding new ones via semanage, unlike for example
>> users, ports, nodes, and interfaces.  For the rest, I was wondering
>why
>> we don't save the linked file and just reuse it on those changes
>rather
>> than re-linking each time - that seems like it would be
>straightforward
>
>We originally kept the linked copy around and had intended to do what 
>you are saying above but removed it when the minimal Red Hat guys 
>complained about the size of it.
>
>> to do in libsemanage and make those operations significantly faster
>and
>> less memory intensive.
>
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to
>Selinux-request@tycho.nsa.gov.

-- 
Sent from my Samsung Galaxy Note 2 with K-9 Mail.
