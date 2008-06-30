Message-ID: <48693652.9040305@tycho.nsa.gov>
Date: Mon, 30 Jun 2008 15:38:58 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Ted Toth <txtoth@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: X avcs
References: <195F0BAA-7896-416C-9897-E191080161D4@nall.com> <47EC1760.7050504@tycho.nsa.gov> <F3CB74C1-A379-4B76-A41B-E7282D0C580A@nall.com>
In-Reply-To: <F3CB74C1-A379-4B76-A41B-E7282D0C580A@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
> On Mar 27, 2008, at 4:53 PM, Eamon Walsh wrote:
>   
>> It's a write-down violation.  Your X server is running at system low  
>> so the root window and root colormap are at system low.  "add child"  
>> is considered a write operation.
>>
>> Have you tried running the X server at SystemHigh?
>>     
>
> Yes. I set up a SystemHigh range transition for X and twm. xinit can't  
> talk to X unless the user level is SystemHigh as well.
>
> type=USER_AVC msg=audit(1214783769.178:696): user pid=21164 uid=500  
> auid=500 ses=5 subj=user_u:user_r:user_xserver_t:s15:c0.c1023  
> msg='avc:  denied  { getattr } for request=X11:CreateGC comm=xinit  
> resid=4c restype=WINDOW scontext=user_u:user_r:user_t:s0  
> tcontext=user_u:object_r:user_rootwindow_t:s15:c0.c1023  
> tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,  
> terminal=tty1)'
> type=USER_AVC msg=audit(1214783769.182:697): user pid=21164 uid=500  
> auid=500 ses=5 subj=user_u:user_r:user_xserver_t:s15:c0.c1023  
> msg='avc:  denied  { get_property } for request=X11:GetProperty  
> comm=xinit resid=4c restype=WINDOW scontext=user_u:user_r:user_t:s0  
> tcontext=user_u:object_r:user_rootwindow_t:s15:c0.c1023  
> tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?,  
> terminal=tty1)'
>
> X can't manage its log file from SystemHigh either
>
> type=AVC msg=audit(1214783768.255:680): avc:  denied  { rename } for   
> pid=21164 comm="X" name="Xorg.0.log" dev=dm-0 ino=85120  
> scontext=user_u:user_r:user_xserver_t:s15:c0.c1023  
> tcontext=user_u:object_r:xserver_log_t:s0 tclass=file
> type=AVC msg=audit(1214783768.255:680): avc:  denied  { unlink } for   
> pid=21164 comm="X" name="Xorg.0.log.old" dev=dm-0 ino=85114  
> scontext=user_u:user_r:user_xserver_t:s15:c0.c1023  
> tcontext=user_u:object_r:xserver_log_t:s0 tclass=file
>
> type=AVC msg=audit(1214784233.205:729): avc:  denied  { write } for   
> pid=21225 comm="X" name="log" dev=dm-0 ino=81922  
> scontext=user_u:user_r:user_xserver_t:s15:c0.c1023  
> tcontext=system_u:object_r:var_log_t:s0-s15:c0.c1023 tclass=dir
>
> I'm really struggling to understand the tau of MLS SELinux X (probably  
> because I don't grok X internals yet). What should be level of the  
> rootwindow be? It seems like whether it is SystemHigh or SystemLow,  
> processes at a different level are going to need fairly serious privs  
> to be able to write to the rootwindow.
>   

The mls constraints in refpolicy are probably not correct as they relate 
to the root window.  There has been some discussion of this in an 
earlier thread [1] but no follow up on really sitting down and defining 
the MLS semantics.  The standard categorization of permissions into 
"read" and "write" bins may not be sufficient to adequately describe MLS 
for X window objects.

I'll go through the x_drawable permissions and try to categorize each 
one in terms of MLS:

create
destroy
    Not applicable to the root window, which cannot be created or 
destroyed by user applications.

read
    The problem here is that if you can "read" the contents of a window, 
you can also read the contents of _all_ child windows within it.  This 
means that if you have "read" permission on the root window, you can 
take a screen shot of the entire desktop.  Thus, only processes running 
at SystemHigh should be able to read the root window.

write
    If you can draw into a window, you can also scribble on child 
windows.  Meaning that if you have "write" permission on the root 
window, you can write into any window on the desktop.  Also you could 
spoof windows by simply drawing images into the root window.  So again 
this is a SystemHigh permission.
   
blend
    Blend permission on the root window means that an application is 
attempting to use the Composite extension to redirect the contents of 
the window and its subwindows into a memory buffer for use by the 
application.  This is how compositing managers work.  (The other use 
case of the blend permission, making a window with a transparent 
background, does not apply to the root window because the root window 
always has a solid background).  This is a SystemHigh permission.

getattr
    Normal applications will need to do this.  You should only need 
SystemLow to be able to do this.

setattr
    This permission protects several operations on the root window, 
including setting its background image or background color, setting the 
colormap, and setting the mouse cursor displayed when the cursor is in 
the window.  Only SystemHigh applications should be able to do this.  If 
there is a scenario where a normal application needs this permission, 
then setattr probably needs to be split up into multiple permissions 
depending on what the use case is.

list_child
    This returns the window ID's of all the direct child windows of the 
root window.  This does leak out the number of such windows, which 
client number they belong to, and the stacking order the windows are 
in.  However I don't view this as a major leak, since to find out 
anything additional about a window (besides its ID) you would have to 
make additional protocol requests and go through more access control.  
If you really don't want this leaking out, then only SystemHigh 
applications should be able to do this.  Otherwise SystemLow can do this.

add_child
remove_child
list_property
get_property
   SystemLow should be able to do these.  Everyone needs to create and 
remove windows and read some common properties on the root window.

set_property
    I'm pretty sure that SystemLow will also need the ability to do 
this.  However, window properties could serve as a mechanism for leaking 
data between clients running at different levels.  A client may also be 
able to affect the behavior of other applications by messing with 
property values on the root window.  The various conventions for using 
root window properties need to be examined, and x_contexts labels, 
policy rules, and/or polyinstantiation applied as needed.

manage
override
show
hide
    "manage" permission controls doing window-manager type things like 
moving and resizing the window, reparenting it, raising and lowering 
it.  Override is setting the override-redirect bit on the window.  Show 
and hide are mapping and unmapping the window, respectively.  Like 
create and destroy, none of these permissions are really applicable to 
the root window, since it can't ever be hidden, moved, resized, etc.

send
receive
    Send controls the ability to send events to the root window either 
by using XSendEvent programmatically, or when a device event such as a 
mouse click happens in the root window.  Receive controls the ability to 
register an event mask on the root window, allowing the application to 
receive events that are sent to the root window.  As with properties 
above, allowing this for SystemLow could result in open communications 
between applications at different levels.  However there are certain 
ICCCM conventions that involve regular applications sending an event to 
the root window in order to communicate with the window manager.


[1] http://marc.info/?l=selinux&m=119990105012347&w=2


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
