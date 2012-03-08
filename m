Subject: Re: CTS failure on SEAndroid Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Subramani Venkatesh <selinuxv31@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAD8iFzynBoUg_O+9LU3rmxasCYKK3GPed5hGdSeSoKgNppa7Bg@mail.gmail.com>
References: 
	 <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
	 <1331127372.16697.21.camel@moss-pluto>
	 <CAD8iFzwjZbUsmPJan6tU-un9goYWxZFbrykqYXr3HU+o6ea1_Q@mail.gmail.com>
	 <1331129177.16697.26.camel@moss-pluto>
	 <1331131202.16697.39.camel@moss-pluto>
	 <1331152083.16697.73.camel@moss-pluto>
	 <CAD8iFzynBoUg_O+9LU3rmxasCYKK3GPed5hGdSeSoKgNppa7Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Mar 2012 11:18:22 -0500
Message-ID: <1331223502.13585.112.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-03-08 at 11:09 -0500, Subramani Venkatesh wrote:
> Hi Stephen,
> I collected some log about AVC denial running CTS in permissive mode,
> I am seeing most of the calls being denied on binder( receive and
> call), and all CTS apps are under untrusted_app domain, though I can
> add the fix in cts.te to continue execution CTS, I am concerned in
> future if someone enables android_cts and still can install some
> untrusted app( May be not part of CTS).  How does this work? or is
> android_cts is for only development platform?

Did you update to our latest policy?  Make sure you use the latest
local_manifest.xml file,
http://selinuxproject.org/~seandroid/local_manifest.xml
so that you use our sepolicy project and not the (not yet updated) AOSP
one.  Then run repo sync -j1 with that local_manifest.xml file in
your .repo subdirectory.

The denials you listed should already be fixed with our latest tree.
I'm still investigating some other denials during CTS execution.

The concept of the android_cts boolean is to allow certain permissions
for the CTS instrumentation on the device that aren't
necessary/desirable for production devices.  So it would only be enabled
when running the CTS normally.

An alternative would be to assign the CTS packages specific app domains
by specifying their package names in seapp_contexts and defining a
cts_app domain in the policy with the requisite permissions.  However,
as package names are arbitrary and there is no namespace control over
who can use what names, that would be less safe in practice - any third
party app could use the same name.  That only really works for system
apps where you know that the package is pre-installed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
