Subject: Re: [PATCH] (SCH-i515 US LTE) Added device specific policy and
 file context files.[PUBLIC DOMAIN]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1331221727.13585.104.camel@moss-pluto>
References: <1331083722-5732-1-git-send-email-bryan@bryanhinton.com>
	 <1331221727.13585.104.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Mar 2012 10:53:11 -0500
Message-ID: <1331221991.13585.106.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-03-08 at 10:48 -0500, Stephen Smalley wrote:
> On Tue, 2012-03-06 at 19:28 -0600, Bryan Hinton wrote:
> > Change-Id: Iaf0aa012e48dd3084aae6f57c25a022b210308ff
> > ---
> >  sepolicy.fc |   13 +++++++++++++
> >  sepolicy.te |    4 ++++
> >  2 files changed, 17 insertions(+), 0 deletions(-)
> >  create mode 100644 sepolicy.fc
> >  create mode 100644 sepolicy.te
> > 
> > diff --git a/sepolicy.fc b/sepolicy.fc
> > new file mode 100644
> > index 0000000..b2f612b
> > --- /dev/null
> > +++ b/sepolicy.fc
> > @@ -0,0 +1,13 @@
> > +/dev/cdma_.*   u:object_r:radio_device:s0
> > +/dev/lte_.*    u:object_r:radio_device:s0
> > +
> > +/dev/ttyO3     u:object_r:nfc_device:s0
> > +
> > +/data/data/com.android.providers.telephony/databases(/.*)? u:object_r:radio_data_file:s0
> > +/data/data/com.android.providers.telephony/optable.db    u:object_r:radio_data_file:s0
> > +
> > +/data/radio/nv_data.bin.*  u:object_r:radio_data_file:s0
> > +/factory(/.*)?             u:object_r:efs_file:s0
> > +/factory/nv_data.bin.*     u:object_r:radio_data_file:s0
> > +
> > +/sys/devices/platform/nfc-power/nfc_power -- u:object_r:sysfs_nfc_power_writable:s0
> 
> I was thinking some of these could go into the base file_contexts and
> only the ones that are truly unique to this device would go here.  In
> particular, /data/data/com.android.providers.telephony seems to be a
> standard part of Android.  Not sure about the rest.  If the device or
> file name is relatively standard and would apply to more than one
> device, then we can add it to file_contexts.  If it is truly unique to
> that one device or might refer to something completely different on a
> different device (as with tty03), then it should stay in the per-device
> file.

Actually, the /data/data/com.android.providers.telephony directory is
already labeled radio_data_file because it has the radio UID and
seapp_contexts specifies radio_data_file for user=radio.  So I don't
believe you need those entries at all.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
