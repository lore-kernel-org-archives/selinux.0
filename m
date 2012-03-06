Subject: Re: Login context for a VNC connection
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andy Warner <warner@rubix.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <4F567572.5060705@rubix.com>
References: <4F567572.5060705@rubix.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Mar 2012 15:47:06 -0500
Message-ID: <1331066826.26027.134.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-06 at 21:37 +0100, Andy Warner wrote:
> I am trying to configure the login context for a user connection
> through Tiger VNC. I am using RHEL6 with the MLS policy, fully
> updated. Currently I am getting:
> 
> system_u:system_r:initrc_t:SystemLow-SystemHigh
> 
> This does not seem correct. Can someone please give me information on
> hos this context is calculated and how I can configure it so the user
> receives a context of my choosing. 

Most likely means that the Tiger VNC server is not labeled, thus left in
the caller's context (initrc_t), and either does not try to set the user
session context at all (i.e. no pam_selinux in its pam config) or fails
to determine a context because it is starting from a context that is not
specified as part
of /etc/selinux/$SELINUXTYPE/contexts/default_contexts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
