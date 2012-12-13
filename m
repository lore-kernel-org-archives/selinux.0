From: "Langland, Blake" <blangland@integrity-apps.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: SELinux networking question
Date: Thu, 13 Dec 2012 19:42:13 +0000
Message-ID: <DA8D339A60101247B36E202899B1C93A2D86D1@CHUNEX01.integrity-apps.com>
References: <DA8D339A60101247B36E202899B1C93A2D5684@CHUNEX01.integrity-apps.com>
 <50CA15A5.9040607@tycho.nsa.gov>
In-Reply-To: <50CA15A5.9040607@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your help, Stephen. It is working as intended now.

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Thursday, December 13, 2012 9:52 AM
To: Langland, Blake
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux networking question

On 12/13/2012 11:21 AM, Langland, Blake wrote:
> Hello,
>
> I am attempting to set up a server using SELinux and the MLS policy. I 
> am having trouble restricting network access of this server. There 
> will be a windows machine acting as a client, receiving UDP messages 
> from the server. What I would like to do is restrict what data can be 
> sent to the windows machine based upon the context of the sending process.
>
> I have tried to set the sensitivity level of the client node using 
> semanage node command, but traffic is still able to be sent from a 
> process with a higher sensitivity level. Am I missing a step?
>
> Thanks for any suggestions you can give me.

You need to configure netlabel, e.g. see:
http://paulmoore.livejournal.com/7632.html



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
