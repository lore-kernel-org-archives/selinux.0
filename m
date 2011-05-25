Message-ID: <SNT139-w12F20E4434CD66A07C8FE8AB740@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a1db0cc3-4531-4d57-9dff-1aaf8a1931db_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <eparis@redhat.com>, Roy <rongqing.li@windriver.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, <jmorris@namei.org>,
        <eparis@parisplace.org>, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 0/2] Review request for reorganizing the role
 transition rule
Date: Wed, 25 May 2011 03:23:24 +0000
In-Reply-To: <4DDBA986.4000207@redhat.com>
References: 
 <1306230374-29019-1-git-send-email-rongqing.li@windriver.com>,<4DDBA986.4000207@redhat.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_a1db0cc3-4531-4d57-9dff-1aaf8a1931db_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Eric,

Yep, you are right, technically these two patches are right, but for the time being considering that there are only 5 role transition rules, single list would be a better data structure to organize them than a hash table.

There is no outstanding underlying problem that these two patches are trying to fix, just that when adding the class support to the role transition rules, 
Stephen mentioned that we may want to re-organize the role transition rules in hash table as what has been done for the range transition, which has 30+ such rules now.

So re-organize role transition rules in hash table does has added complexity now, but I guess they would be more desirable in the future when full RBAC is implemented.

Many thanks for your comments !

Best regards,
Harry

> Date: Tue, 24 May 2011 08:50:14 -0400
> From: eparis@redhat.com
> To: rongqing.li@windriver.com
> CC: sds@tycho.nsa.gov; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Subject: Re: [v0 PATCH 0/2] Review request for reorganizing the role transition rule
> 
> On 05/24/2011 05:46 AM, rongqing.li@windriver.com wrote:
> > Comments:
> > ---------
> > Organize the roletr in hash table rather than single list.
> 
> Why?  I'm not opposed to the change, but it is added complexity.  How
> many such rules exist?  How often are they searched?  What was that
> underlying problem for the patch?
> 
> -Eric
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_a1db0cc3-4531-4d57-9dff-1aaf8a1931db_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'>
Hi Eric,<br><br>Yep, you are right, technically these two patches are right, but for the time being considering that there are only 5 role transition rules, single list would be a better data structure to organize them than a hash table.<br><br>There is no outstanding underlying problem that these two patches are trying to fix, just that when adding the class support to the role transition rules, <br>Stephen mentioned that we may want to re-organize the role transition rules in hash table as what has been done for the range transition, which has 30+ such rules now.<br><br>So re-organize role transition rules in hash table does has added complexity now, but I guess they would be more desirable in the future when full RBAC is implemented.<br><br>Many thanks for your comments !<br><br>Best regards,<br>Harry<br><br>&gt; Date: Tue, 24 May 2011 08:50:14 -0400<br>&gt; From: eparis@redhat.com<br>&gt; To: rongqing.li@windriver.com<br>&gt; CC: sds@tycho.nsa.gov; jmorris@namei.org; epa!
 ris@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Subject: Re: [v0 PATCH 0/2] Review request for reorganizing the role transition rule<br>&gt; <br>&gt; On 05/24/2011 05:46 AM, rongqing.li@windriver.com wrote:<br>&gt; &gt; Comments:<br>&gt; &gt; ---------<br>&gt; &gt; Organize the roletr in hash table rather than single list.<br>&gt; <br>&gt; Why?  I'm not opposed to the change, but it is added complexity.  How<br>&gt; many such rules exist?  How often are they searched?  What was that<br>&gt; underlying problem for the patch?<br>&gt; <br>&gt; -Eric<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_a1db0cc3-4531-4d57-9dff-1aaf8a1931db_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
