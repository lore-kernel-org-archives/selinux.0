MIME-Version: 1.0
In-Reply-To: <1331223502.13585.112.camel@moss-pluto>
References: <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
	<1331127372.16697.21.camel@moss-pluto>
	<CAD8iFzwjZbUsmPJan6tU-un9goYWxZFbrykqYXr3HU+o6ea1_Q@mail.gmail.com>
	<1331129177.16697.26.camel@moss-pluto>
	<1331131202.16697.39.camel@moss-pluto>
	<1331152083.16697.73.camel@moss-pluto>
	<CAD8iFzynBoUg_O+9LU3rmxasCYKK3GPed5hGdSeSoKgNppa7Bg@mail.gmail.com>
	<1331223502.13585.112.camel@moss-pluto>
Date: Thu, 8 Mar 2012 11:47:42 -0500
Message-ID: <CAD8iFzx-7CKQ3dErg5UDRjm05UeRMw5koBMF9mDcfzSwLzr2og@mail.gmail.com>
Subject: Re: CTS failure on SEAndroid Galaxy Nexus
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Stephen, Thought I have latest local_manifest,  I had to sync
this morning, seeing new changes, will let you know how it goes.

-Subbu

On Thu, Mar 8, 2012 at 11:18 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2012-03-08 at 11:09 -0500, Subramani Venkatesh wrote:
>> Hi Stephen,
>> I collected some log about AVC denial running CTS in permissive mode,
>> I am seeing most of the calls being denied on binder( receive and
>> call), and all CTS apps are under untrusted_app domain, though I can
>> add the fix in cts.te to continue da CTS, I am concerned in
>> future if someone enables android_cts and still can install some
>> untrusted app( May be not part of CTS).  How does this work? or is
>> android_cts is for only development platform?
>
> Did you update to our latest policy?  Make sure you use the latest
> local_manifest.xml file,
> http://selinuxproject.org/~seandroid/local_manifest.xml
> so that you use our sepolicy project and not the (not yet updated) AOSP
> one.  Then run repo sync -j1 with that local_manifest.xml file in
> your .repo subdirectory.
>
> The denials you listed should already be fixed with our latest tree.
> I'm still investigating some other denials during CTS execution.
>
> The concept of the android_cts boolean is to allow certain permissions
> for the CTS instrumentation on the device that aren't
> necessary/desirable for production devices.  So it would only be enabled
> when running the CTS normally.
>
> An alternative would be to assign the CTS packages specific app domains
> by specifying their package names in seapp_contexts and defining a
> cts_app domain in the policy with the requisite permissions.  However,
> as package names are arbitrary and there is no namespace control over
> who can use what names, that would be less safe in practice - any third
> party app could use the same name.  That only really works for system
> apps where you know that the package is pre-installed.
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
