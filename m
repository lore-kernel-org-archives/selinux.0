Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q28LFI4E028460
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2012 16:15:18 -0500
Received: by yhjj72 with SMTP id j72so575260yhj.12
        for <selinux@tycho.nsa.gov>; Thu, 08 Mar 2012 13:15:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1331221727.13585.104.camel@moss-pluto>
References: <1331083722-5732-1-git-send-email-bryan@bryanhinton.com>
	<1331221727.13585.104.camel@moss-pluto>
Date: Thu, 8 Mar 2012 15:15:16 -0600
Message-ID: <CA+XzHeM=CZMXm9b3h8gu9va-FG7rntGkyCH=+gA_g=LOx0H1NA@mail.gmail.com>
Subject: Re: [PATCH] (SCH-i515 US LTE) Added device specific policy and file
 context files.[PUBLIC DOMAIN]
From: Bryan Hinton <bryan@bryanhinton.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please see comments at bottom.

On Thu, Mar 8, 2012 at 9:48 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2012-03-06 at 19:28 -0600, Bryan Hinton wrote:
>> Change-Id: Iaf0aa012e48dd3084aae6f57c25a022b210308ff
>> ---
>>  sepolicy.fc |   13 +++++++++++++
>>  sepolicy.te |    4 ++++
>>  2 files changed, 17 insertions(+), 0 deletions(-)
>>  create mode 100644 sepolicy.fc
>>  create mode 100644 sepolicy.te
>>
>> diff --git a/sepolicy.fc b/sepolicy.fc
>> new file mode 100644
>> index 0000000..b2f612b
>> --- /dev/null
>> +++ b/sepolicy.fc
>> @@ -0,0 +1,13 @@
>> +/dev/cdma_.*   u:object_r:radio_device:s0
>> +/dev/lte_.*    u:object_r:radio_device:s0
>> +
>> +/dev/ttyO3     u:object_r:nfc_device:s0
>> +
>> +/data/data/com.android.providers.telephony/databases(/.*)? u:object_r:radio_data_file:s0
>> +/data/data/com.android.providers.telephony/optable.db    u:object_r:radio_data_file:s0
>> +
>> +/data/radio/nv_data.bin.*  u:object_r:radio_data_file:s0
>> +/factory(/.*)?             u:object_r:efs_file:s0
>> +/factory/nv_data.bin.*     u:object_r:radio_data_file:s0
>> +
>> +/sys/devices/platform/nfc-power/nfc_power -- u:object_r:sysfs_nfc_power_writable:s0
>
> I was thinking some of these could go into the base file_contexts and
> only the ones that are truly unique to this device would go here.  In
> particular, /data/data/com.android.providers.telephony seems to be a
> standard part of Android.  Not sure about the rest.  If the device or
> file name is relatively standard and would apply to more than one
> device, then we can add it to file_contexts.  If it is truly unique to
> that one device or might refer to something completely different on a
> different device (as with tty03), then it should stay in the per-device
> file.
>
>> diff --git a/sepolicy.te b/sepolicy.te
>> new file mode 100644
>> index 0000000..2964ae1
>> --- /dev/null
>> +++ b/sepolicy.te
>> @@ -0,0 +1,4 @@
>> +type sysfs_nfc_power_writable, fs_type, sysfs_type, mlstrustedobject;
>> +
>> +allow domain sysfs_nfc_power_writable:file rw_file_perms;
>> +allow rild self:netlink_route_socket { setopt };
>
> I think at least the last rule can go in the base policy rather than be
> device-specific.  I'm still not sure whether/why nfc_power needs to be
> world writable; that worries me a little.  init.tuna.rc sets the mode to
> 0600, so it isn't world readable/writable as far as DAC is concerned
> (unless something changes it later - what does ls -l show on the
> device?).  Is it perhaps opened by the zygote and inherited by all
> descendants?  Or might it be an unintentional descriptor leak?  What
> happens if you just dontaudit it rather than allow it?  Does it truly
> appear for all domains or a particular set (e.g. all app domains, all
> daemon domains, ...)?

I just looked into what is going on with this and I came to the same conclusion.
It appears that the internal chip is being sent a power reset command
over the uart via the object attribute - nfc_power -  in sys/ when nfc
is turned on (i.e. device wakeup).  It seems that access to this path
in sys should be tightly confined.  And yes, the open descriptor is a
problem which I think can be fixed by limiting access to the path in
sys by setting the label on the file so that only the Nfc system app
can read/write it.
Also, when NFC is off, SELinux is in Enforcing mode, and the device
goes to sleep, then upon device wakeup when you enable NFC via
Settings -> NFC On, the attempt to enable NFC will fail.  As far as I
can tell, this is a non-deterministic bug as I have not been able to
reproduce it every time.


>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
