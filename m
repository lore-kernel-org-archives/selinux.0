Date: Sun, 24 Oct 2004 16:40:09 -0700
From: Nifty Hat Mitch <mitch48@sbcglobal.net>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: mv and cp behavior.
Message-ID: <20041024234009.GB714@xtl1.xtl.tenegg.com>
References: <41712EEF.9090402@redhat.com> <1098105487.27895.40.camel@moss-spartans.epoch.ncsc.mil> <1098115678.6101.30.camel@decepticon.boston.redhat.com> <1098119648.27895.150.camel@moss-spartans.epoch.ncsc.mil> <1098121436.6101.56.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098121436.6101.56.camel@decepticon.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, Oct 18, 2004 at 01:43:56PM -0400, Colin Walters wrote:
> On Mon, 2004-10-18 at 13:14 -0400, Stephen Smalley wrote:
> 
> > Ok, but if you were able to use chcon to set the type in the first
> > place, then you presumably are able to use it after moving files there
> > in Dan's example scenario.
> 
> Right; this was just a related issue, not quite the same thing as Dan's
....
> Yeah.  I'm kind of curious why Dan wrote the dhcp.conf in /tmp and later
> moved it to /etc; I'd imagine most admins would just
> $EDITOR /etc/dhcp.conf.

I am not sure why Dan would but, in a large site administration context
I might expect that that "$EDITOR /etc/dhcp.conf" is not permitted.
Some places want to have testing, approval and change log policy.

Something like these untested lines.
  scp approved-new-dhcp.conf  user@keyhost:~/approved-new-dhcp.conf
  ssh user@keyhost sudo mv /etc/dhcp.conf /etc/dhcp.conf.save`date +%s`
  ssh user@keyhost sudo mv ~/approved-new-dhcp.conf /etc/dhcp.conf
  ssh user@keyhost sudo service dhcpd reload

Anyhow some staged approval process with an audit trail....



-- 
	T o m  M i t c h e l l 
	May your cup runneth over with goodness and mercy
	and may your buffers never overflow.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
