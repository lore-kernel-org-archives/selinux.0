Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OHg23c028068
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 13:42:02 -0400
Received: from web51505.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2OHfxQR024305
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 17:41:59 GMT
Date: Mon, 24 Mar 2008 08:55:13 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Permissive mode for xace is broken.
To: Eamon Walsh <ewalsh@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <729568.16778.qm@web51505.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



----- Original Message ----
> From: Eamon Walsh <ewalsh@tycho.nsa.gov>
> To: Steve Grubb <sgrubb@redhat.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>; Daniel J Walsh <dwalsh@redhat.com>; SE Linux <selinux@tycho.nsa.gov>
> Sent: Wednesday, March 19, 2008 11:56:00 PM
> Subject: Re: Permissive mode for xace is broken.
> 
> Steve Grubb wrote:
> > On Thursday 28 February 2008 21:02:28 Eamon Walsh wrote:
> >   
> >> Steve Grubb wrote:
> >>     
> >>> On Thursday 28 February 2008 13:51:05 Stephen Smalley wrote:
> >>>       
> >>>> On Thu, 2008-02-28 at 13:48 -0500, Eamon Walsh wrote:
> >>>>         
> >>>>> Stephen Smalley wrote:
> >>>>>           
> >>>>>> On Mon, 2008-02-25 at 20:12 -0500, Eamon Walsh wrote:
> >>>>>>             
> >>>>>>> Eamon Walsh wrote:
> >>>>>>>               
> >>>>>>>> The X object manager logs all avc's and status messages (including
> >>>>>>>> the AVC netlink stuff) through the audit system using libaudit calls
> >>>>>>>> (audit_log_user_avc_message, etc.)
> >>>>>>>>                 
> >>> Please tell me they have different record types. Also do you have any
> >>> samples that we can look over to make sure they conform?
> >>>       
> >> type=USER_AVC msg=audit(1204226161.048:268): user pid=21267 uid=0
> >> auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023
> >> msg='avc:  denied  { read } for request=X11:QueryPointer
> >> comm=/usr/libexec/at-spi-registryd xdevice="Virtual core pointer"
> >> scontext=staff_u:staff_r:staff_t:s0
> >> tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device :
> >> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
> >>     
> >
> > comm & xdevice are not escaped the right way. exe is. The audit utilities are 
> > expecting the comm field to be comm="/usr/libexec/at-spi-registryd" in this 
> > case. The standard has been untrusted fields have " " enclosing the field. 
> > Whenever there is a space, double quote, or control character, its ASCII HEX 
> > encoded with no quotes. xdevice is not a field that the audit system knows 
> > about, so we could do something different with it, but comm is known for a 
> > long time and has to follow the standards.
> >   
> 
> Why can't libaudit automatically perform this escaping?

Well, it could. However, this is the API that you currently have:

extern int audit_log_user_avc_message(int audit_fd, int type,
        const char *message, const char *hostname, const char *addr,
        const char *tty, uid_t uid);

The whole avc from msg=  up to the exe= statement comes from libselinux. So, libselinux has to do the escaping unless we build a better API for selinux use. I could probably expose the function that does the escaping, but I had really wanted to try to maintain some consistency in the event by API.


>  That way we avoid promulgating this "standard" into every caller of libaudit.
> 
> If everything is going to be name-value based, then I want a libaudit 
> function that takes a list of name/value pairs.

SE Linux is the only user of the audit system that does not follow the name=value standard. Would you (and the community) really be willing to convert selinux over to that if we have the API for it?  Do you have any suggestions about how you'd like to see the new API implemented?


> > Also, is there any information about who caused the event? uid, auid, gid? 
> > Even though this was a denied action, what is the results? Were they 
> > successful (permissive) or was it really a failed and denied request?
> >   
> 
> I don't understand this last part with the result of the action.  How am 
> I supposed to specify this?

res=0 for failed and res=1 for success even though the action was denied. Admittedly, the audit avc API does not require this from SE Linux, but I could fix that if we change the API to something around name value pairs.


> I need to modify libselinux (again) to support all of this extra uid and 
> hostname stuff getting passed into the logging callback.

Yes, CAPP and other CC protection profiles require that sufficient information be logged to determine who did the action that was denied or granted. 

 
> > Would it make sense to fill in the workspace:window information for the 
> > terminal? If X is being used remotely, is the addr & hostname fields correct?
> >   
> 
> The X server has a terminal that it runs on, /dev/tty7 or whatever.  The 
> desktop workspaces and gnome-terminal/xterm pseudo-tty's are external to 
> the X server and it doesn't know about them.

So, should we also make a new field that logs the workspace:window that a request came from?

Thanks,
-Steve





      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
