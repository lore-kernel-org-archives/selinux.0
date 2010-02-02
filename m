Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o12G6lXj022015
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 11:06:47 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o12G6bp5004592
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 16:06:37 GMT
Message-ID: <4B684DB6.7080401@redhat.com>
Date: Tue, 02 Feb 2010 11:07:18 -0500
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
It is a bug in fedora rawhide.  I will fix tonight.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
