Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8TJZAwm014547
 for <selinux@tycho.nsa.gov>; Tue, 29 Sep 2015 15:35:10 -0400
Received: by padhy16 with SMTP id hy16so14518988pad.1
 for <selinux@tycho.nsa.gov>; Tue, 29 Sep 2015 12:35:08 -0700 (PDT)
Message-ID: <560AE7E4.4040401@quarksecurity.com>
Date: Tue, 29 Sep 2015 15:35:00 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Find attributes for a type with sepol
References: <476DC76E7D1DF2438D32BFADF679FC5601077F23@ORSMSX103.amr.corp.intel.com>
 <5603EFE8.6010505@tycho.nsa.gov> <5603F39A.6060607@tycho.nsa.gov>
 <5604018A.5030805@quarksecurity.com>
 <CAFftDdrfvJVhCifZ4tpoBd89v-RSDF2v9gYm3RwbBNFZHzqFcQ@mail.gmail.com>
 <560AE27B.7070602@quarksecurity.com>
 <CAFftDdpyUtkUKeRg7d98vVeU3ZOWMq1RCr+5DHcyOur2xh_gYw@mail.gmail.com>
In-Reply-To: <CAFftDdpyUtkUKeRg7d98vVeU3ZOWMq1RCr+5DHcyOur2xh_gYw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

William Roberts wrote:
> On Sep 29, 2015 12:12 PM, "Joshua Brindle"<brindle@quarksecurity.com>
> wrote:
>> William Roberts wrote:
>>> Out of curiosity, whats the purpose of the types field in the struct
>>> type_datum? This seems to never have anything in it.
>>>
>> type_datum is used for both types and attributes (as designated by the
> flavor field). In the attribute case the types field is the ebitmap of
> types have have this attribute.
>
> What about if its a type, is it an ebitmap of attrs?

No, but as Stephen said below there is a type_attr_map that contains that.

>
> It is set in checkpolicy, look at policy_define.c:define_typeattribute().
>>
>>
>>> Also, conditional.h has a field called bool, this would seem to conflict
>>> with stdbool.h, whats the consensus on renaming this to boolean perhaps?
>>>
>> probably...
>>
>>
>>> On Thu, Sep 24, 2015 at 6:58 AM, Joshua Brindle<brindle@quarksecurity.com
>>> wrote:
>>>
>>>> Stephen Smalley wrote:
>>>>
>>>>> On 09/24/2015 08:43 AM, James Carter wrote:
>>>>>
>>>>>> On 09/23/2015 06:39 PM, Roberts, William C wrote:
>>>>>>
>>>>>>> How would one find all the attributes of a type with libsepol, can
>>>>>>> someone point me to any relevant structures or functions?
>>>>>>>
>>>>>>> The policydb_t structure has type_attr_map field which maps types to
> an
>>>>>> ebitmap of attributes.
>>>>>>
>>>>> It also has the reverse map (attr_type_map) if you want that.
>>>>>
>>>>> In Android, external/sepolicy/tools/sepolicy-analyze has examples of
>>>>> using both maps.
>>>>>
>>>>>
>>>> seinfo also knows how to do it, if you need more examples:
>>>>
>>>> $ seinfo -x -tuntrusted_app sepolicy
>>>>      untrusted_app
>>>>         bluetoothdomain
>>>>         netdomain
>>>>         appdomain
>>>>         domain
>>>>
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>>>>
>>>
>>>
>
