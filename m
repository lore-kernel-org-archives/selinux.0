To: Nicolas Iooss <nicolas.iooss@m4x.org>, Petr Lautrbach <plautrba@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
References: <20180214095337.1945-1-plautrba@redhat.com>
 <CAJfZ7==9Xj-dXKygmcc2u5o811mA35JUv_9jtaHJu4TPXewB0A@mail.gmail.com>
 <CAJfZ7==fjyC6Uh9CGJ=rqc+uG1MZt08AgPv5PY6V-rx23Dtz3w@mail.gmail.com>
 <20180222153145.GB29029@workstation> <20180222165940.GC29029@workstation>
 <CAJfZ7=kEiuzk=D1o84ipDyJ5pMRuyC5NGR+xdVzt-5eBM_cbPQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3ded63ce-85f9-ae4c-66ef-88abf9083c14@tycho.nsa.gov>
Date: Fri, 23 Feb 2018 15:29:31 -0500
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=kEiuzk=D1o84ipDyJ5pMRuyC5NGR+xdVzt-5eBM_cbPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Update selinux-sepolgengui to be compatible with Gtk3, Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/22/2018 02:09 PM, Nicolas Iooss wrote:

> On Thu, Feb 22, 2018 at 5:59 PM, Petr Lautrbach <plautrba@redhat.com> wrote:
>> On Thu, Feb 22, 2018 at 04:31:46PM +0100, Petr Lautrbach wrote:
>>> On Sun, Feb 18, 2018 at 07:20:02PM +0100, Nicolas Iooss wrote:
>>>> On Sun, Feb 18, 2018 at 7:09 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>>>> On Wed, Feb 14, 2018 at 10:53 AM, Petr Lautrbach <plautrba@redhat.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> The following set of patches update polgengui.py, rename polgen.glade to
>>>>>> polgen.ui, convert it to new format, and fix some other sepolicy Python 3
>>>>>> related issues.
>>>>> Hi,
>>>>> I have read and tested these patches and they look good to me.
>>>> (Oops, the mail has been sent before I finished writing it...)
>>>>
>>>> In order to run polgengui on my development system which uses a policy
>>>> without MLS, I needed a patch in sepolicy, that I sent a few days ago
>>>> ("[PATCH 1/3] python/sepolicy: Support non-MLS policy"). With this I
>>>> have been able to play with polgengui and have been surprised by a
>>>> warning which appears on my terminal every time I type anything in the
>>>> "name" field of the form in the second tab ("Enter name of application
>>>> or user role:"):
>>>>
>>>> polgengui.py:778: Warning: g_value_get_int: assertion
>>>> 'G_VALUE_HOLDS_INT (value)' failed
>>>>   Gtk.main()
>>>>
>>>> Have you got such warning on your system? Do you know where this
>>>> warning comes from? For information I use Gtk3 3.22.26 with
>>>> python-gobject 3.26.1.
>>>
>>> I see it as well. I'll try to find the problem and sent a patch for that.
>> It's caused by line 624 in polgengui.py
>>
>> 624        self.name_entry.connect("insert_text", self.on_name_entry_changed)
>>
>> According to [2][3] it's long term known problem. There's a suggested fix in [1]
>> but I don't know how to apply it at this moment.
>>
>> Given that it's not fatal and doesn't have a real impact on the code - you can't
>> insert " " into Name value, I'd leave as it is for now.
>>
>> [1] https://stackoverflow.com/questions/38815694/gtk-3-position-attribute-on-insert-text-signal-from-gtk-entry-is-always-0
>> [2] https://bugzilla.gnome.org/show_bug.cgi?id=644927
>> [3] https://gitlab.gnome.org/GNOME/pygobject/issues/12
>>
>>
>> There's another deprecation warning:
>>
>> /usr/share/system-config-selinux/polgengui.py:679: PyGIDeprecationWarning: Deprecated, please use stop_emission_by_name.
>>   entry.emit_stop_by_name("insert_text")
>>
>> which seems to be easy to fix
>>
>> --- a/gui/polgengui.py
>> +++ b/gui/polgengui.py
>> @@ -674,7 +674,7 @@ class childWindow:
>>
>>      def on_name_entry_changed(self, entry, text, size, position):
>>          if text.find(" ") >= 0:
>> -            entry.emit_stop_by_name("insert_text")
>> +            entry.stop_emission_by_name("insert-text")
>>
>>      def on_focus_out_event(self, entry, third):
>>          name = entry.get_text()
>>
>>
>> I'll send a patch for that.
> Excellent! Unfortunately I will be travelling the next ten days and I
> will not be able to review or test your patches before my return. The
> review can of course be done by another maintainer, so there is no
> issue.
>
>
Thanks, merged via https://github.com/SELinuxProject/selinux/pull/80
