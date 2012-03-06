Message-ID: <4F556212.50303@schaufler-ca.com>
Date: Mon, 05 Mar 2012 17:02:10 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: noloader@gmail.com
CC: SE Linux <SELinux@tycho.nsa.gov>, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: SE Android and Finer Grained Permissions
References: <CAH8yC8kE6fEGijSyjz4_VrqoogbrqLAsHwCXsRQH3qd52e=kVw@mail.gmail.com>
In-Reply-To: <CAH8yC8kE6fEGijSyjz4_VrqoogbrqLAsHwCXsRQH3qd52e=kVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/4/2012 6:02 PM, Jeffrey Walton wrote:
> Hi All,
>
> Forgive my ignorance here.....
>
> I was reading the slides at on SE Android at
> http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf.
>
> I see the slides point out "[Current Android suffers] limited
> granularity, coarse-grained privilege." But I don't see where SE
> Android corrected it. For example, it appears READ_PHONE_STATE still
> encompasses reading a device serial number, IMEI, SIM ID, call state,
> incoming calling number, etc.
>
> Does SE Android remediate the coarse grained permissions?
>
> Is an application installation still an "all or nothing" proposition
> with respect to permissions? For example, can I approve an install and
> later take away the WRITE_CONTACTS permission?

I personally applaud the coarser granularity that the Android policy
has over the Fedora policy. I have long been critical of what I
consider to be excesses of granularity in SELinux. Do you really want
to see 900,000 lines of policy for a handset device? And before
someone starts to claim that the handset system software is somehow
smaller or less complex than the Fedora distribution I will point to
Stephen's note about the application enforced policy of Android.

Fine granularity in access controls are lots of fun for engineers
and seem like a good idea when you want to turn on a particular
facility and can't do so because the seemingly unrelated implications
are too dangerous. But it's a slippery slope, and I seriously doubt
that anyone would want to truly understand all the relationships
included in a policy for Android that matches the granularity of the
policy for Fedora.

But, that's my well known opinion, and as such you may wish to take
it with a grain of salt. I will be sad to see the Android policy grow
with the same unbridled exuberance as the Fedora and reference policies.


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
