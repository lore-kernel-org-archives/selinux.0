Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o12Fwifd021228
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 10:58:44 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o12FwYp5029346
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 15:58:34 GMT
Message-ID: <4B684BD3.8020000@redhat.com>
Date: Tue, 02 Feb 2010 10:59:15 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: (WW) file_contexts:  line 0 has invalid context system_u:object_r:info_xproperty_t:s0
References: <4B6843D3.6010106@gmail.com>
In-Reply-To: <4B6843D3.6010106@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/02/2010 10:25 AM, Dominick Grift wrote:
> I Get this in Xorg.0.log when booting:
> 
> kernel-2.6.32.7-37.fc12.x86_64
> selinux-policy-mls-3.7.8-5.fc13.noarch
> 
> (WW) file_contexts:  line 0 has invalid context
> system_u:object_r:info_xproperty_t:s0
> SELinux: a property label lookup failed!
> Fatal server error:
> SELinux: Failed to set label property on window!
> 
> Any idea what may be causing this?
> 

Nope.

That was defined up until f12 policy but not in rawhide.

seinfo  -t | grep xprop
   mozilla_xproperty_t
   seclabel_xproperty_t
   remote_xproperty_t
   tvtime_xproperty_t
   vmware_xproperty_t
   ethereal_xproperty_t
   bluetooth_helper_xproperty_t
   games_xproperty_t
   clipboard_xproperty_t
   mplayer_xproperty_t
   nsplugin_xproperty_t
   sandbox_xserver_xproperty_t
   ssh_xproperty_t
   xdm_xproperty_t
   xproperty_t
   java_xproperty_t
   root_xproperty_t
   user_xproperty_t

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
