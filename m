Message-ID: <453518AB.4020303@tresys.com>
Date: Tue, 17 Oct 2006 13:53:47 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 1/4] libselinux flask definition update for context class
References: <4534FDF8.2000609@trustedcs.com>
In-Reply-To: <4534FDF8.2000609@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> Update SELinux flask definition to include the context security class.
> This also adds the "process setsockcreate" and "association polmatch" 
> string
> definitions that have been missing.
> 
> Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>
> 
> ---
> 
> include/selinux/av_permissions.h |   76 
> ---------------------------------------

Why all the whitespace changes?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
