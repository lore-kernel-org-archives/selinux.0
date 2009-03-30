Date: Mon, 30 Mar 2009 15:03:42 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090330200342.GF1155@Sun.COM>
References: <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain> <49D10FC1.3000103@sun.com> <20090330200121.GD9992@Sun.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090330200121.GD9992@Sun.COM>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 30, 2009 at 03:01:21PM -0500, Nicolas Williams wrote:
> I believe that certificate extensions and Kerberos V authorization-data
> could be used to ensure that the client and server both know the correct
> "label encodings" for their shared DOIs.

Of course, this does nothing for deployments that don't use PKIX or
Kerberos V.  We can do something like this for all trusted third-party
distributed authentication systems.  But for simple pre-shared key (PSK)
and simpler schemes (e.g., AUTH_SYS) there's nothing we can do: the
client and server will have to agree on a DOI and label encodings a
priori.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
