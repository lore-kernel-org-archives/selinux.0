From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: svirt on MLS has strange AVC.
Date: Tue, 30 Mar 2010 16:30:05 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
References: <4BA7E4BF.1040002@redhat.com> <1269976831.9831.13.camel@moss-pluto.epoch.ncsc.mil> <1269980250.2941.31.camel@dhcp235-240.rdu.redhat.com>
In-Reply-To: <1269980250.2941.31.camel@dhcp235-240.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201003301630.08190.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 March 2010 04:17:30 pm Eric Paris wrote:
> ... As we see with libvirt and KVM/QEMU we have to change the application.   
> eww.

To be fair, let's remember that you got into this condition because you 
changed the application, libvirtd, to run a child process with a different 
label - once you start doing wacky stuff, you need to be prepared to do more 
wacky stuff to get it to work properly :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
