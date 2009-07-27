MIME-Version: 1.0
In-Reply-To: <1248717964.3465.47.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
	 <1248702334.3465.45.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890907270749o7cdced5bw434454ec3f5c91a4@mail.gmail.com>
	 <1248717964.3465.47.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 27 Jul 2009 11:37:52 -0700
Message-ID: <47aa07810907271137s6f84231ud45a54bc036bf522@mail.gmail.com>
Subject: Re: "Error! Unable to set executable context."
From: Larry <selinux@8martialartsforhealth.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 27, 2009 at 11:06 AM, Stephen Smalley<sds@tycho.nsa.gov> wrote:
> On Mon, 2009-07-27 at 07:49 -0700, Larry Ross wrote:
>> On Mon, Jul 27, 2009 at 6:45 AM, Stephen Smalley <sds@tycho.nsa.gov>
>> wrote:
>>         On Sat, 2009-07-25 at 12:41 -0700, Larry Ross wrote:
>>
>>         > I am trying to create a custom selinux user for the strict
>>         policy on
>>         > RHEL5.3
>>         > I want logins that are mapped to this user to be able to
>>         login via
>>         > gdm, but when they do I get an error "Error! Unable to set
>>         executable
>>         > context."
>>         >
>>         > What does this error message mean?
>>         >
>>         > I am able to login via gdm with logins that are mapped to
>>         user_u.  I
>>         > have run the AVCs generated when I login in permissive mode
>>         (which
>>         > succeeds) through audit2allow and gotten to the point where
>>         it doesn't
>>         > seem that I am getting any killer AVCs.  What am I missing
>>         that is
>>         > needed for a custom user to use X-Windows?  Is there some
>>         place I can
>>         > look to determine what is causing the error?
>>
>>
>>         I see that you've resolved the problem now, but could you
>>         describe what
>>         you had to do to get it to work for future reference?  That
>>         way the next
>>         time someone comes along with the same issue, they can find
>>         the answer
>>         in the mailing list archives.
>>
>> I think (and that is why I didn't say specifically) that it was
>> calling:
>> userdom_unpriv_user_template(app_user)
>>
>> I know I needed to add a default context to:
>> /etc/selinux/strict/contexts/default_contexts
>>
>> but although I added more per Dominicks suggestion, I think I already
>> had the ones that were needed.
>>
>>
>>
>>         BTW, "executable context" in the error message means that the
>>         attempts
>>         by gdm to invoke setexeccon(3) failed.  setexecon(3) is the
>>         libselinux
>>         interface to set the security context to which the process
>>         will
>>         transition upon the next execve(2) call.  Usually a
>>         setexeccon(3) error
>>         means that the security context was invalid under the current
>>         policy.
>>
>> This didn't seem to be well documented anywhere as to what the above
>> actually means.
>> My take is that there has to be an executable context (which is what I
>> think the userdom_unpriv_user_template gave me) which is listed in the
>> default contexts in the same row as the "current" context.  But I
>> could be wrong.
>
> Usually what happens is that it is unable to find any valid context for
> the user and thus falls back to trying a failsafe context defined for
> emergency logins, but that wasn't valid for that particular SELinux
> user.

Where is that behavior implemented?  I didn't see it.  Where are the
"failsafe" contexts defined, are they in the code somewhere?

When you say "wasn't valid for that particular SELinux user" I assume
you mean that the permissions required were not given to that selinux
user (which is what I think I fixed with the
userdom_unpriv_user_template).  Which would imply that there would be
no "failsafe context" for my custom selinux user.

  -- Larry

>
> --
> Stephen Smalley
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
