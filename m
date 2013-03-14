From: "Langland, Blake" <blangland@integrity-apps.com>
To: Linda Knippers <linda.knippers@hp.com>, Chad Hanson <dahchanson@gmail.com>
CC: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: SELinux network labeling
Date: Thu, 14 Mar 2013 15:37:10 +0000
Message-ID: <DA8D339A60101247B36E202899B1C93A7C9428@CHUNEX01.integrity-apps.com>
References: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com>
	<2547229.Czz0AkDGmt@sifl>
	<DA8D339A60101247B36E202899B1C93A7C93C5@CHUNEX01.integrity-apps.com>
	<3265214.svHSTcnaWD@sifl>
 <CAOFCXeeoEdMkWze354_Fn=9=3Vv8L_t9sn0vRXY-qGLhvMb2DQ@mail.gmail.com>
 <5141EBD1.5050005@hp.com>
In-Reply-To: <5141EBD1.5050005@hp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oh, great! Does any documentation exist on how to set up Openswan labeling? I was unable to find any.

-----Original Message-----
From: Linda Knippers [mailto:linda.knippers@hp.com] 
Sent: Thursday, March 14, 2013 8:25 AM
To: Chad Hanson
Cc: Paul Moore; Langland, Blake; Stephen Smalley; selinux@tycho.nsa.gov
Subject: Re: SELinux network labeling

Chad Hanson wrote:
> 
> On Wed, Mar 13, 2013 at 1:55 PM, Paul Moore <paul@paul-moore.com 
> <mailto:paul@paul-moore.com>> wrote:
> 
>     On Wednesday, March 13, 2013 05:29:47 PM Langland, Blake wrote:twork
>     traffic
> 
>     > The reason I ruled that out IPSec labeling is that we are using
>     Openswan for
>     > IPSec and it is my understanding after talking with Josh Brindle that
>     > labeling is not supported in Openswan. Are there any plans to
>     bring labeled
>     > associations to Openswan?
> 
>     I haven't tested it lately but my understanding is that the version of
>     Openswan shipped with RHEL6 supports labeled IPsec.  I am unsure
>     about other
>     distributions.
> 
> 
> Openswan supports labeling in RHEL 6, although it looks like there may 
> have been a policy issue which was probably resolved by RHEL 6.3 from 
> looking at this Red Hat Bugzilla report:
>  https://bugzilla.redhat.com/show_bug.cgi?id=748971

Openswan was used for labeled IPsec in the CC evaluation of RHEL6.2.  There were a handful of bug fixes that landed in RHEL6.3. I don't recall that one specifically but it doesn't surprise me.

-- ljk



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
