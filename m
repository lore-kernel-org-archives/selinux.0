Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RFUkrT020765
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 11:30:47 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RFTwpX001384
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 15:29:59 GMT
Date: Fri, 27 Aug 2004 16:42:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Greg KH <greg@kroah.com>, Bill Nottingham <notting@redhat.com>,
   harald@redhat.com, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
Message-ID: <20040827154200.GB4760@lkcl.net>
References: <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com> <412E20AF.7000102@redhat.com> <20040826175139.GA12225@kroah.com> <412E34EB.1030909@redhat.com> <20040826225928.GD6058@lkcl.net> <20040826225640.GA13818@kroah.com> <412F37D2.7070105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <412F37D2.7070105@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 27, 2004 at 09:32:02AM -0400, Daniel J Walsh wrote:

> Further cleanup and using all static inlines versus defines.  Renamed a 
> couple of functions to make them clearer.
 
> +}
> +static inline void selinux_setfilecon(char *file, unsigned int mode) { 
> +	if (is_selinux_running()) {
> +		security_context_t scontext=NULL;
> +		if (matchpathcon(file, mode, &scontext) < 0) {
> +			dbg("matchpathcon(%s) failed\n", file);
> +		} else {
> +			
> +			if (setfilecon(file, scontext) < 0)
> +				dbg("setfiles %s failed with error '%s'",
> +				    file, strerror(errno));
> +			freecon(scontext);
> +		}
> +	}
> +}
> +
> +static inline void selinux_setfscreatecon(char *file, unsigned int mode) {
> +	int retval = 0;
> +	security_context_t scontext=NULL;
> +
> +	if (is_selinux_running()) {
> +		if (matchpathcon(file, S_IFDIR, &scontext) < 0) {
                               ^^^^^^^

	this should be matchpathcon(file, mode, &scontext)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
