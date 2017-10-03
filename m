Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v93DHf69001937
 for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2017 09:17:41 -0400
Received: by mail-oi0-f71.google.com with SMTP id p126so8103272oih.2
 for <selinux@tycho.nsa.gov>; Tue, 03 Oct 2017 06:14:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507035507.17197.5.camel@tycho.nsa.gov>
References: <CA+RmS-8tfA9fkvY3AWviFdCrrYu8=FhtB=J9__rz_DMcGosoQw@mail.gmail.com>
 <1507035507.17197.5.camel@tycho.nsa.gov>
From: David Graziano <david.graziano@rockwellcollins.com>
Date: Tue, 3 Oct 2017 08:13:41 -0500
Message-ID: <CA+RmS--Ag+M_MSrHjyopdQ0A2EvBsa0A1d5nB6+MOvXhYxmN6w@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Labeling sysfs files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 3, 2017 at 7:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2017-10-02 at 16:54 -0500, David Graziano wrote:
>> I'm trying to find a way of labeling specific files/directories in
>> sysfs that do not exist at boot time. I'm running an embedded SELinux
>> enabled system (4.1 series kernel) where at boot there is an init
>> script performing a restorecon on /sys.  Sometime later a usb
>> cellular
>> modem is powered on and enumerated at which point the it's sysfs
>> sub-directory structure is added.
>>
>> This directory path is correctly getting my custom label via
>> restorecon during boot
>> /sys/devices/platform/xxxx/yyyy/fsl-ehci.0/usb1/
>>
>> After the cellular modem is powered on the following directory
>> structure is created.
>> /sys/devices/platform/xxxx/yyyy/fsl-ehci.0/usb1/1-1/1-
>> 1:1.10/net/wwan1/qmi
>> Everything "1-1" and lower that is getting the "default" sysfs_t
>> label.
>>
>> Is there a method of labeling that newly added sub-directory
>> structure
>> other than running restorecond or restorecon again? I specifically
>> need to control access to the "qmi" file. I've tried adding a
>> genfscon
>> to the policy but it doesn't seem to work although I don't know if
>> it's suppose to.
>>
>> Any advice would be appreciated.
>
> You could cherry-pick kernel commits
> 134509d54e4e98888be2697a92cb4b48957b792b and
> 8e01472078763ebc1eaea089a1adab75dd982ccd to gain support for genfscon
> labeling of sysfs entries.  Looks like they apply ok on 4.1, although I
> haven't built or tested that. I think that's your best option.
>

Thanks for the info. I will try cherry-picking those commits.
- David
