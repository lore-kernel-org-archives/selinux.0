Message-ID: <50CA15A5.9040607@tycho.nsa.gov>
Date: Thu, 13 Dec 2012 12:51:33 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Langland, Blake" <blangland@integrity-apps.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: SELinux networking question
References: <DA8D339A60101247B36E202899B1C93A2D5684@CHUNEX01.integrity-apps.com>
In-Reply-To: <DA8D339A60101247B36E202899B1C93A2D5684@CHUNEX01.integrity-apps.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/2012 11:21 AM, Langland, Blake wrote:
> Hello,
>
> I am attempting to set up a server using SELinux and the MLS policy. I
> am having trouble restricting network access of this server. There will
> be a windows machine acting as a client, receiving UDP messages from the
> server. What I would like to do is restrict what data can be sent to the
> windows machine based upon the context of the sending process.
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
