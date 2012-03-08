MIME-Version: 1.0
In-Reply-To: <1331152083.16697.73.camel@moss-pluto>
References: <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
	<1331127372.16697.21.camel@moss-pluto>
	<CAD8iFzwjZbUsmPJan6tU-un9goYWxZFbrykqYXr3HU+o6ea1_Q@mail.gmail.com>
	<1331129177.16697.26.camel@moss-pluto>
	<1331131202.16697.39.camel@moss-pluto>
	<1331152083.16697.73.camel@moss-pluto>
Date: Thu, 8 Mar 2012 11:09:55 -0500
Message-ID: <CAD8iFzynBoUg_O+9LU3rmxasCYKK3GPed5hGdSeSoKgNppa7Bg@mail.gmail.com>
Subject: Re: CTS failure on SEAndroid Galaxy Nexus
From: Subramani Venkatesh <selinuxv31@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,
I collected some log about AVC denial running CTS in permissive mode,
I am seeing most of the calls being denied on binder( receive and
call), and all CTS apps are under untrusted_app domain, though I can
add the fix in cts.te to continue execution CTS, I am concerned in
future if someone enables android_cts and still can install some
untrusted app( May be not part of CTS).  How does this work? or is
android_cts is for only development platform?

Here is the log

<5>[  505.486053] type=1400 audit(1331221519.312:4): avc:  denied  {
receive } for  pid=462 comm=42696E646572205468726561642023
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:shell:s0 tclass=binder
<5>[  506.026611] type=1400 audit(1331221519.851:5): avc:  denied  {
receive } for  pid=109 comm="servicemanager"
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:radio:s0 tclass=binder
<5>[  506.027191] type=1400 audit(1331221519.851:6): avc:  denied  {
call } for  pid=1086 comm="eInfoInstrument"
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:radio:s0 tclass=binder
<5>[  519.138549] type=1400 audit(1331221532.960:7): avc:  denied  {
use } for  pid=1093 comm="df"
path=2F6465762F5F5F70726F706572746965735F5F202864656C6574656429
dev=tmpfs ino=1041 scontext=u:r:untrusted_app:s0:c41
tcontext=u:r:kernel:s0 tclass=fd
<5>[  519.138702] type=1400 audit(1331221532.960:8): avc:  denied  {
read } for  pid=1093 comm="df"
path=2F6465762F5F5F70726F706572746965735F5F202864656C6574656429
dev=tmpfs ino=1041 scontext=u:r:untrusted_app:s0:c41
tcontext=u:object_r:tmpfs:s0 tclass=file
<5>[  565.803955] type=1400 audit(1331221579.632:9): avc:  denied  {
receive } for  pid=397 comm=42696E646572205468726561642023
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:shell:s0 tclass=binder
<5>[  566.417846] type=1400 audit(1331221580.242:10): avc:  denied  {
call } for  pid=1207 comm="ationTestRunner"
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:shell:s0 tclass=binder
<5>[  576.880157] type=1400 audit(1331221590.703:11): avc:  denied  {
receive } for  pid=384 comm=42696E646572205468726561642023
scontext=u:r:untrusted_app:s0:c40 tcontext=u:r:shell:s0 tclass=binder
<5>[  576.943878] type=1400 audit(1331221590.765:12): avc:  denied  {
call } for  pid=1306 comm="ationTestRunner"
scontext=u:r:untrusted_app:s0:c40 tcontext=u:r:shell:s0 tclass=binder
<5>[  584.875183] type=1400 audit(1331221598.703:13): avc:  denied  {
receive } for  pid=462 comm=42696E646572205468726561642023
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:shell:s0 tclass=binder
<5>[  584.936218] type=1400 audit(1331221598.757:14): avc:  denied  {
call } for  pid=1376 comm="onCtsTestRunner"
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:shell:s0 tclass=binder
<5>[  588.049377] type=1400 audit(1331221601.875:15): avc:  denied  {
call } for  pid=1376 comm="onCtsTestRunner"
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:shell:s0 tclass=binder
<5>[  597.659912] type=1400 audit(1331221611.484:16): avc:  denied  {
receive } for  pid=217 comm=42696E646572205468726561642023
scontext=u:r:untrusted_app:s0:c41 tcontext=u:r:shell:s0 tclass=binder
<5>[  618.888977] type=1400 audit(1331221632.710:17): avc:  denied  {
receive } for  pid=218 comm=42696E646572205468726561642023
scontext=u:r:untrusted_app:s0:c38 tcontext=u:r:shell:s0 tclass=binder
<5>[  618.962188] type=1400 audit(1331221632.789:18): avc:  denied  {
call } for  pid=1953 comm="ationTestRunner"
scontext=u:r:untrusted_app:s0:c38 tcontext=u:r:shell:s0 tclass=binder


Regards,
Subbu

On Wed, Mar 7, 2012 at 3:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2012-03-07 at 09:40 -0500, Stephen Smalley wrote:
>> Just tried this myself, and I see that we'll need to make a few
>> adjustments to policy for the current CTS.  Some of those will be made
>> unconditionally outside of the android_cts boolean, while others are
>> really only appropriate under test conditions and not production use.
>
> I tracked down a subtle issue that was being hidden by a dontaudit rule
> in the policy, and updated sepolicy for various denials that I saw in
> getting the latest CTS started.  No guarantees that it will run all the
> way through, but it certainly gets started now.  Prior to running the
> CTS, I do the following:
>
> adb shell su 0 setsebool android_cts=1
> adb shell su 0 setenforce 1
> adb shell su 0 cat /proc/kmsg > dmesg.txt &
> adb logcat *:E > log.txt &
>
> Later you can do something like the following to reduce dmesg.txt to
> just the unique allow rules for easy review, although you would
> typically evaluate each one to decide whether it should be generalized
> (e.g. written in terms of a type attribute or using a macro), changed to
> introduce a new domain or type, or replaced with a dontaudit rule.
>
> audit2allow -p out/target/product/<device>/root/sepolicy.24 < dmesg.txt
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
