Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9FHF6AQ015738
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2008 13:15:06 -0400
Message-ID: <48F62519.8070805@tycho.nsa.gov>
Date: Wed, 15 Oct 2008 13:15:05 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Trying to figure out the signature of a screen capture.
References: <48F61C6A.6090703@redhat.com>
In-Reply-To: <48F61C6A.6090703@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I wanted to see if we could prevent nsplugin_t from screen capturing
> random parts of the Desktop.
>
> So I relabeled /usr/bin/gimp as nsplugin_exec_t, then ran it to get
> AVC's, when capturing a screen image, sadly no AVC's were generated, so
> nsplugin_t can capture screen images.
>
> I Wanted to see what avc's are created when you screen capture that are
> different from running a standard X App, so I labeled /usr/bin/gimp and
> put the machine in permissive mode.  Ran gimp to the point of capturing
> the screen capture, and cleared the log files.
>
> When capturing the image I got the following allow rules.
>
> allow gpg_t focus_xevent_t:x_event receive;
> allow gpg_t input_xevent_t:x_event receive;
> allow gpg_t self:x_cursor destroy;
> allow gpg_t xdm_rootwindow_t:x_drawable { read setattr };
> allow gpg_t xdm_xserver_t:x_device { freeze force_cursor bell };
>
>
> Is there anything we could eliminate from common X Apps, to prevent
> nsplgugin from screen capture.

It's "read" permission on the root window.  Remember that if you can
read a window, you can read all of its children as well.  So having read
on the root means you can see everything.

Most apps shouldn't have this, and I don't see it granted in the current
policy.  Actually I think GIMP launches a helper app to actually do the
screencap.  I remember seeing its path in the AVC message.  So maybe
that's why it's not working for you.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
