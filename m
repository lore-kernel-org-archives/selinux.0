Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2D1Zmhw010320
	for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2013 21:35:48 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so512793obc.6
        for <selinux@tycho.nsa.gov>; Tue, 12 Mar 2013 18:35:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com>
References: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com>
Date: Tue, 12 Mar 2013 21:35:46 -0400
Message-ID: <CAHC9VhRJDUpjPrYrXbrF=u2D_i1G_fA1ueCVUfdxbfUdg7BweA@mail.gmail.com>
Subject: Re: SELinux network labeling
From: Paul Moore <paul@paul-moore.com>
To: "Langland, Blake" <blangland@integrity-apps.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Mar 12, 2013 at 4:55 PM, Langland, Blake
<blangland@integrity-apps.com> wrote:
> Hello,

Hello.

> I am trying to set up a system using SELinux system that needs to have
> certain network traffic blocked based on the MLS label. Basically, there are
> two machines running SELinux (call them A and B). Both machines have two
> processes, say A1 and B1 are at sensitivity s0, and A2 and B2 are at s1. I
> want to let process A1 talk to B1, and A2 talk to B2, but block A1->B2, and
> A2->B1. Without using labeled IPsec, what systems for network labeling
> should I use?

Based on what you have written I think you will be best served with a
network peer labeling protocol, SELinux supports two network peer
labeling protocols: labeled IPsec and NetLabel/CIPSO.  Since you have
ruled out labeled IPsec it looks like your best choice is
NetLabel/CIPSO.

> With the Netlabel fallback labels I am not able to specify the
> port.

Yes, the NetLabel fallback labels only have granularity to the host
level.  Although even if you could specify the port I don't think it
would work the way you want it to work; for example, how would you
handle the client applications and the ephemeral ports?  If you use a
peer labeling protocol, such as NetLabel/CIPSO, then the security
label is taken directly from the security label of the sending process
(really the sending socket, but that detail likely isn't important
here) so you don't have to worry about changing network addresses
and/or ports.

> I currently am setting the label via secmark based on the source,
> destination, and port, and then running each process at the appropriate
> level, and also have the port labeled at the appropriate level. This is not
> blocking the traffic I want it to.

You didn't provide any details about your configuration so we can only
guess as to why it is not working, however, I believe you are better
served by using NetLabel/CIPSO and not secmark.  Secmark, like the
NetLabel/fallback labels relies on information from the network
headers, not the sending process, to generate the security label, as a
result it can be easy to run afoul of changes in network configuration
and often doesn't represent clients very well due to the ephemeral
port problem.

To be clear, secmark does have its uses, I'm just not sure from what
you've described that it is the best solution for what you are trying
to accomplish.

> I have been reading Paul Moore’s blogs about Secmark and network labeling
> and am a little bit confused about packet vs. peer labeling.

The short version is this: network peer labels represent the security
label of the process (socket), e.g. s0, that originally generated the
network traffic, secmark/iptables (I'm guessing this is what you meant
by "packet labels") labels represent the network attributes, e.g.
destination port, of the network traffic.  Network peer labels help
you say "I only want Top Secret clients to connect to this Top Secret
server" whereas secmark labels help you say "I only want TCP port 80
packets to connect to this server".

> Are both packet and peer labeling required?

You can use neither approach, one, or both; it is up to you.

> If only packet labeling is required, what is causing the
> scheme explained above to not block traffic?

Once again, you didn't give us much to go on, but like I said I think
NetLabel/CIPSO is the better solution.

If you can share some more information, or at least provide a simple
demo/example case, we might be able to provide a more concrete example
solution for you.

-Paul

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
