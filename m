Message-ID: <4AA96193.7020905@tycho.nsa.gov>
Date: Thu, 10 Sep 2009 16:29:07 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: XACE: tclass malformed
References: <20090910160307.GA6469@notebook3.grift.internal>
In-Reply-To: <20090910160307.GA6469@notebook3.grift.internal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/10/2009 12:03 PM, Dominick Grift wrote:
> Some XACE avc denials end up in /var/log/messages as opposed to /var/log/audit/audit.log. These particular XACE avc denials appear with a malformed tclass field:
>
> Example:
>
> Sep 10 17:50:31 notebook3 Xephyr: Can't send to audit system: USER_AVC avc:  denied  { get_property } for request=X11:GetProperty comm=/usr/bin/xterm resid=102 restype=WINDOW scontext=dgrift_u:dgrift_r:sandbox_x_client_t:s0:c29,c36 tcontext=dgrift_u:object_r:sandbox_xserver_t:s0:c29,c36 tclass=x_drawable#012: exe="/usr/bin/Xephyr" sauid=0 hostname=? addr=? terminal=?
>
> note the: tclass=x_drawable#012:
>
> I believe this may be the reason why these avc denials end up in /var/log/messages instead of /var/log/audit/audit.log , but i am not sure.
>
>    

Can you take a look in /var/log/Xorg.0.log.  The same avc's are printed 
there, please let me know if the message is malformed in the Xorg.0.log 
file as well.



-- 
Eamon Walsh<ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
