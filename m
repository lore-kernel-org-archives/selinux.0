MIME-Version: 1.0
In-Reply-To: <4BD19D9C.4090306@manicmethod.com>
References: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
	 <4BD19D9C.4090306@manicmethod.com>
Date: Fri, 23 Apr 2010 09:53:03 -0400
Message-ID: <q2y7e0fb38c1004230653x7759766mace25e9f22d4eb88@mail.gmail.com>
Subject: Re: [PATCH 1/3] SELinux: standardize return code handling in
	policydb.c
From: Eric Paris <eparis@parisplace.org>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 23, 2010 at 9:16 AM, Joshua Brindle <method@manicmethod.com> wrote:
>
>
> Eric Paris wrote:
>>
>> policydb.c has lots of different standards on how to handle return paths
>> on
>> error.  For the most part transition to
>>
>>        rc=errno
>>        if (failure)
>>                goto out;
>> [...]
>> out:
>>        cleanup()
>>        return rc;
>>
>> Instead of doing cleanup mid function, or having multiple returns or other
>> options.  This doesn't do that for every function, but most of the complex
>> functions which have cleanup routines on error.
>>
>
> Any chance the same fixes could be made in libsepol policydb.c? :)

If people like that style I can attack libsepol too.  James doesn't
quite seem sold yet....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
