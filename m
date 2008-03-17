From: Steve Grubb <sgrubb@redhat.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
Date: Mon, 17 Mar 2008 16:11:08 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <47C2CC18.6080801@redhat.com> <200802281617.17223.sgrubb@redhat.com> <47C767B4.7060606@tycho.nsa.gov>
In-Reply-To: <47C767B4.7060606@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803171611.08351.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 28 February 2008 21:02:28 Eamon Walsh wrote:
> Steve Grubb wrote:
> > On Thursday 28 February 2008 13:51:05 Stephen Smalley wrote:
> >> On Thu, 2008-02-28 at 13:48 -0500, Eamon Walsh wrote:
> >>> Stephen Smalley wrote:
> >>>> On Mon, 2008-02-25 at 20:12 -0500, Eamon Walsh wrote:
> >>>>> Eamon Walsh wrote:
> >>>>>> The X object manager logs all avc's and status messages (including
> >>>>>> the AVC netlink stuff) through the audit system using libaudit calls
> >>>>>> (audit_log_user_avc_message, etc.)
> >
> > Please tell me they have different record types. Also do you have any
> > samples that we can look over to make sure they conform?
>
> type=USER_AVC msg=audit(1204226161.048:268): user pid=21267 uid=0
> auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023
> msg='avc:  denied  { read } for request=X11:QueryPointer
> comm=/usr/libexec/at-spi-registryd xdevice="Virtual core pointer"
> scontext=staff_u:staff_r:staff_t:s0
> tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device :
> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'

comm & xdevice are not escaped the right way. exe is. The audit utilities are 
expecting the comm field to be comm="/usr/libexec/at-spi-registryd" in this 
case. The standard has been untrusted fields have " " enclosing the field. 
Whenever there is a space, double quote, or control character, its ASCII HEX 
encoded with no quotes. xdevice is not a field that the audit system knows 
about, so we could do something different with it, but comm is known for a 
long time and has to follow the standards.

Also, is there any information about who caused the event? uid, auid, gid? 
Even though this was a denied action, what is the results? Were they 
successful (permissive) or was it really a failed and denied request?

Would it make sense to fill in the workspace:window information for the 
terminal? If X is being used remotely, is the addr & hostname fields correct?

That's the only things I notice at this point.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
