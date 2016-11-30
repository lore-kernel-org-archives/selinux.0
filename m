Subject: Re: [PATCH] policycoreutils/sepolicy/gui: fix current selinux state
 radiobutton
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
References: <1480410540-5192-1-git-send-email-vmojzis@redhat.com>
 <6c878032-bddc-2a83-2eec-818a6769a8ad@tycho.nsa.gov>
 <5717f0f3-0322-21b2-692e-c1c5fc8ac40f@redhat.com>
 <b1b99022-af12-0dec-194a-423765dd32e8@tycho.nsa.gov>
From: Vit Mojzis <vmojzis@redhat.com>
Message-ID: <15202ae0-3133-0a2e-950c-1d4bf59c4eb9@redhat.com>
Date: Wed, 30 Nov 2016 15:24:13 +0100
MIME-Version: 1.0
In-Reply-To: <b1b99022-af12-0dec-194a-423765dd32e8@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is caused by recent changes in sepolicy that were not reflected in 
gui. I'm working on the issue, but it's probably gonna take some time.

Thanks for the feedback.


On 30.11.2016 14:52, Stephen Smalley wrote:
> On 11/30/2016 08:44 AM, Vit Mojzis wrote:
>> The glade file is installed properly, only
>> python/sepolicy/sepolicy/gui.py is searching for it in the wrong place
>> (lib64). Please find attached patch that should fix the issue.
> Thanks, but now I get:
> $ sepolicy gui
>
> (sepolicy:18202): Gtk-WARNING **: Could not load image
> 'images/booleans.png': Failed to open file
> '/usr/lib/python2.7/site-packages/sepolicy/images/booleans.png': No such
> file or directory
>
> (sepolicy:18202): Gtk-WARNING **: Overriding tab label for notebook
> Traceback (most recent call last):
>    File "/usr/bin/sepolicy", line 699, in <module>
>      args.func(args)
>    File "/usr/bin/sepolicy", line 327, in gui_run
>      sepolicy.gui.SELinuxGui(args.domain, args.test)
>    File "/usr/lib/python2.7/site-packages/sepolicy/gui.py", line 517, in
> __init__
>      path = sepolicy.find_entrypoint_path(entrypoint)
>    File "/usr/lib/python2.7/site-packages/sepolicy/__init__.py", line
> 486, in find_entrypoint_path
>      if exe.endswith("_exec_t") and exe not in exclude_list:
> AttributeError: 'list' object has no attribute 'endswith'
>
>>
>> On 29.11.2016 15:02, Stephen Smalley wrote:
>>> On 11/29/2016 04:09 AM, Vit Mojzis wrote:
>>>> Radiobutton was always set to "Permissive" and couldn't be switched.
>>>> Update radiobutton together with status text in bottom left corner.
>>>>
>>>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>>> Thanks, applied.  However, sepolicy gui doesn't work for me (before or
>>> after this change):
>>> $ cd selinux
>>> $ sudo make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap
>>> relabel
>>> $ sepolicy gui
>>> Traceback (most recent call last):
>>>     File "/usr/bin/sepolicy", line 699, in <module>
>>>       args.func(args)
>>>     File "/usr/bin/sepolicy", line 327, in gui_run
>>>       sepolicy.gui.SELinuxGui(args.domain, args.test)
>>>     File "/usr/lib/python2.7/site-packages/sepolicy/gui.py", line 135, in
>>> __init__
>>>       builder.add_from_file(glade_file)
>>> GLib.Error: g-file-error-quark: Failed to open file
>>> '/usr/lib64/python2.7/site-packages/sepolicy/sepolicy.glade': No such
>>> file or directory (4)
>>>
>>> Are we failing to install the glade file properly in the Makefiles?
>>> And does python/sepolicy/sepolicy/sepolicy.glade belong under gui/
>>> instead?
>>>
>>>> ---
>>>>    python/sepolicy/sepolicy/gui.py | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/python/sepolicy/sepolicy/gui.py
>>>> b/python/sepolicy/sepolicy/gui.py
>>>> index ee78e0c..3c5a9d2 100644
>>>> --- a/python/sepolicy/sepolicy/gui.py
>>>> +++ b/python/sepolicy/sepolicy/gui.py
>>>> @@ -2609,9 +2609,10 @@ class SELinuxGui():
>>>>        def set_enforce_text(self, value):
>>>>            if value:
>>>>                self.status_bar.push(self.context_id, _("System Status:
>>>> Enforcing"))
>>>> +            self.current_status_enforcing.set_active(True)
>>>>            else:
>>>>                self.status_bar.push(self.context_id, _("System Status:
>>>> Permissive"))
>>>> -        self.current_status_permissive.set_active(True)
>>>> +            self.current_status_permissive.set_active(True)
>>>>          def set_enforce(self, button):
>>>>            self.dbus.setenforce(button.get_active())
>>>>
