Message-ID: <1507035507.17197.5.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Graziano <david.graziano@rockwellcollins.com>, selinux@tycho.nsa.gov
Date: Tue, 03 Oct 2017 08:58:27 -0400
In-Reply-To: <CA+RmS-8tfA9fkvY3AWviFdCrrYu8=FhtB=J9__rz_DMcGosoQw@mail.gmail.com>
References: <CA+RmS-8tfA9fkvY3AWviFdCrrYu8=FhtB=J9__rz_DMcGosoQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Labeling sysfs files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-10-02 at 16:54 -0500, David Graziano wrote:
> I'm trying to find a way of labeling specific files/directories in
> sysfs that do not exist at boot time. I'm running an embedded SELinux
> enabled system (4.1 series kernel) where at boot there is an init
> script performing a restorecon on /sys.  Sometime later a usb
> cellular
> modem is powered on and enumerated at which point the it's sysfs
> sub-directory structure is added.
> 
> This directory path is correctly getting my custom label via
> restorecon during boot
> /sys/devices/platform/xxxx/yyyy/fsl-ehci.0/usb1/
> 
> After the cellular modem is powered on the following directory
> structure is created.
> /sys/devices/platform/xxxx/yyyy/fsl-ehci.0/usb1/1-1/1-
> 1:1.10/net/wwan1/qmi
> Everything "1-1" and lower that is getting the "default" sysfs_t
> label.
> 
> Is there a method of labeling that newly added sub-directory
> structure
> other than running restorecond or restorecon again? I specifically
> need to control access to the "qmi" file. I've tried adding a
> genfscon
> to the policy but it doesn't seem to work although I don't know if
> it's suppose to.
> 
> Any advice would be appreciated.

You could cherry-pick kernel commits
134509d54e4e98888be2697a92cb4b48957b792b and
8e01472078763ebc1eaea089a1adab75dd982ccd to gain support for genfscon
labeling of sysfs entries.  Looks like they apply ok on 4.1, although I
haven't built or tested that. I think that's your best option.
