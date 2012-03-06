MIME-Version: 1.0
Reply-To: noloader@gmail.com
In-Reply-To: <4F556212.50303@schaufler-ca.com>
References: <CAH8yC8kE6fEGijSyjz4_VrqoogbrqLAsHwCXsRQH3qd52e=kVw@mail.gmail.com>
	<4F556212.50303@schaufler-ca.com>
Date: Mon, 5 Mar 2012 21:39:50 -0500
Message-ID: <CAH8yC8nte8z4Az7C-zU3aB9U0mPJtaPWZofcpgOw8vkUQJ8J3Q@mail.gmail.com>
Subject: Re: SE Android and Finer Grained Permissions
From: Jeffrey Walton <noloader@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SE Linux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Casey,

On Mon, Mar 5, 2012 at 8:02 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/4/2012 6:02 PM, Jeffrey Walton wrote:
>> Forgive my ignorance here.....
>>
>> I was reading the slides at on SE Android at
>> http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf.
>>
>> I see the slides point out "[Current Android suffers] limited
>> granularity, coarse-grained privilege." But I don't see where SE
>> Android corrected it. For example, it appears READ_PHONE_STATE still
>> encompasses reading a device serial number, IMEI, SIM ID, call state,
>> incoming calling number, etc.
>>
>> Does SE Android remediate the coarse grained permissions?
>>
>> Is an application installation still an "all or nothing" proposition
>> with respect to permissions? For example, can I approve an install and
>> later take away the WRITE_CONTACTS permission?
>
>
> I personally applaud the coarser granularity that the Android policy
> has over the Fedora policy. I have long been critical of what I
> consider to be excesses of granularity in SELinux. Do you really want
> to see 900,000 lines of policy for a handset device? And before
> someone starts to claim that the handset system software is somehow
> smaller or less complex than the Fedora distribution I will point to
> Stephen's note about the application enforced policy of Android.
>
> Fine granularity in access controls are lots of fun for engineers
> and seem like a good idea when you want to turn on a particular
> facility and can't do so because the seemingly unrelated implications
> are too dangerous. But it's a slippery slope, and I seriously doubt
> that anyone would want to truly understand all the relationships
> included in a policy for Android that matches the granularity of the
> policy for Fedora.
For what its worth, here's what I envision:

READ_PHONE_STATE gives the house away (confer:
http://android-permissions.org/ and the Permission Map). As a matter
of fact, Goolge forced the permission on *all* apps, whetehr it was
needed or not (confer:
http://stackoverflow.com/questions/1747178/android-permissions-phone-calls-read-phone-state-and-identity).

I want finer permissions than READ_PHONE_STATE. Perhaps
READ_PHONE_UNIQUE_ID, READ_PHONE_IMEI, READ_PHONE_INCOMING_CALLER,
READ_PHONE_LINE_STATE, READ_PHONE_LOG, etc. Ditto for many other
permissions.

When it comes time to install an application, I can look at what
actually is requested (not just READ_PHONE_STATE), and choose Yes or
No. If I choose Yes, I'd like to take away permissions at a later
time. For example, I might get suspicious and remove READ_PHONE_LOG at
a later time.

For the Enterprise, SE Android/Management Server *should* allow one to
do the same, but from a central console. I should be able to install
(or deny an install), or uninstall, or yank a permission at a later
date.

> But, that's my well known opinion, and as such you may wish to take
> it with a grain of salt. I will be sad to see the Android policy grow
> with the same unbridled exuberance as the Fedora and reference policies.
Not at all.

Unfortunately, I can't comment on policy bloat since Fedora works
great for me out of the box as a single user (no Enterprise). Perhaps
the policy tools are lacking. Again, I've never seen their GUIs, but
the front end should be simple for admins and users who understand
policy (confer: Microsoft, MMC, and Local Security Policy or GPOs).

Jeff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
