Return-Path: <SRS0=qDqc=OB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8ADC43441
	for <selinux@archiver.kernel.org>; Thu, 22 Nov 2018 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CCB20820
	for <selinux@archiver.kernel.org>; Thu, 22 Nov 2018 09:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CCB20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbeKVUZL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:25:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732056AbeKVUZL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 22 Nov 2018 15:25:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C075330BB37C;
        Thu, 22 Nov 2018 09:46:28 +0000 (UTC)
Received: from workstation (ovpn-204-50.brq.redhat.com [10.40.204.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF1E24AA;
        Thu, 22 Nov 2018 09:46:27 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/1] gui: remove html_util.py
References: <20181111205024.14386-1-nicolas.iooss@m4x.org>
        <pjdsgzur14f.fsf@redhat.com>
Date:   Thu, 22 Nov 2018 10:46:25 +0100
In-Reply-To: <pjdsgzur14f.fsf@redhat.com> (Petr Lautrbach's message of "Wed,
        21 Nov 2018 14:50:08 +0100")
Message-ID: <pjdk1l5qwb2.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 22 Nov 2018 09:46:28 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
>> This file is not used anywhere.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>


Merged.


>
>
>>  gui/Makefile     |   1 -
>>  gui/html_util.py | 175 -----------------------------------------------
>>  2 files changed, 176 deletions(-)
>>  delete mode 100644 gui/html_util.py
>>
>> diff --git a/gui/Makefile b/gui/Makefile
>> index a72e58cee9b4..d42348b5f7fe 100644
>> --- a/gui/Makefile
>> +++ b/gui/Makefile
>> @@ -9,7 +9,6 @@ TARGETS= \
>>  booleansPage.py \
>>  domainsPage.py \
>>  fcontextPage.py \
>> -html_util.py \
>>  loginsPage.py \
>>  modulesPage.py \
>>  polgen.ui \
>> diff --git a/gui/html_util.py b/gui/html_util.py
>> deleted file mode 100644
>> index 420f6b967114..000000000000
>> --- a/gui/html_util.py
>> +++ /dev/null
>> @@ -1,175 +0,0 @@
>> -# Authors: John Dennis <jdennis@redhat.com>
>> -#
>> -# Copyright (C) 2007 Red Hat, Inc.
>> -#
>> -# This program is free software; you can redistribute it and/or modify
>> -# it under the terms of the GNU General Public License as published by
>> -# the Free Software Foundation; either version 2 of the License, or
>> -# (at your option) any later version.
>> -#
>> -# This program is distributed in the hope that it will be useful,
>> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> -# GNU General Public License for more details.
>> -#
>> -# You should have received a copy of the GNU General Public License
>> -# along with this program; if not, write to the Free Software
>> -# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> -#
>> -
>> -
>> -__all__ = [
>> -    'escape_html',
>> -    'unescape_html',
>> -    'html_to_text',
>> -
>> -    'html_document',
>> -]
>> -
>> -import htmllib
>> -import formatter as Formatter
>> -import string
>> -from types import *
>> -try:
>> -    from io import StringIO
>> -except ImportError:
>> -    from StringIO import StringIO
>> -
>> -#------------------------------------------------------------------------------
>> -
>> -
>> -class TextWriter(Formatter.DumbWriter):
>> -
>> -    def __init__(self, file=None, maxcol=80, indent_width=4):
>> -        Formatter.DumbWriter.__init__(self, file, maxcol)
>> -        self.indent_level = 0
>> -        self.indent_width = indent_width
>> -        self._set_indent()
>> -
>> -    def _set_indent(self):
>> -        self.indent_col = self.indent_level * self.indent_width
>> -        self.indent = ' ' * self.indent_col
>> -
>> -    def new_margin(self, margin, level):
>> -        self.indent_level = level
>> -        self._set_indent()
>> -
>> -    def send_label_data(self, data):
>> -        data = data + ' '
>> -        if len(data) > self.indent_col:
>> -            self.send_literal_data(data)
>> -        else:
>> -            offset = self.indent_col - len(data)
>> -            self.send_literal_data(' ' * offset + data)
>> -
>> -    def send_flowing_data(self, data):
>> -        if not data:
>> -            return
>> -        atbreak = self.atbreak or data[0] in string.whitespace
>> -        col = self.col
>> -        maxcol = self.maxcol
>> -        write = self.file.write
>> -        col = self.col
>> -        if col == 0:
>> -            write(self.indent)
>> -            col = self.indent_col
>> -        for word in data.split():
>> -            if atbreak:
>> -                if col + len(word) >= maxcol:
>> -                    write('\n' + self.indent)
>> -                    col = self.indent_col
>> -                else:
>> -                    write(' ')
>> -                    col = col + 1
>> -            write(word)
>> -            col = col + len(word)
>> -            atbreak = 1
>> -        self.col = col
>> -        self.atbreak = data[-1] in string.whitespace
>> -
>> -
>> -class HTMLParserAnchor(htmllib.HTMLParser):
>> -
>> -    def __init__(self, formatter, verbose=0):
>> -        htmllib.HTMLParser.__init__(self, formatter, verbose)
>> -
>> -    def anchor_bgn(self, href, name, type):
>> -        self.anchor = href
>> -
>> -    def anchor_end(self):
>> -        if self.anchor:
>> -            self.handle_data(' (%s) ' % self.anchor)
>> -            self.anchor = None
>> -
>> -#------------------------------------------------------------------------------
>> -
>> -
>> -def escape_html(s):
>> -    if s is None:
>> -        return None
>> -    s = s.replace("&", "&amp;")  # Must be done first!
>> -    s = s.replace("<", "&lt;")
>> -    s = s.replace(">", "&gt;")
>> -    s = s.replace("'", "&apos;")
>> -    s = s.replace('"', "&quot;")
>> -    return s
>> -
>> -
>> -def unescape_html(s):
>> -    if s is None:
>> -        return None
>> -    if '&' not in s:
>> -        return s
>> -    s = s.replace("&lt;", "<")
>> -    s = s.replace("&gt;", ">")
>> -    s = s.replace("&apos;", "'")
>> -    s = s.replace("&quot;", '"')
>> -    s = s.replace("&amp;", "&")  # Must be last
>> -    return s
>> -
>> -
>> -def html_to_text(html, maxcol=80):
>> -    try:
>> -        buffer = StringIO()
>> -        formatter = Formatter.AbstractFormatter(TextWriter(buffer, maxcol))
>> -        parser = HTMLParserAnchor(formatter)
>> -        parser.feed(html)
>> -        parser.close()
>> -        text = buffer.getvalue()
>> -        buffer.close()
>> -        return text
>> -    except Exception as e:
>> -        log_program.error('cannot convert html to text: %s' % e)
>> -        return None
>> -
>> -
>> -def html_document(*body_components):
>> -    '''Wrap the body components in a HTML document structure with a valid header.
>> -    Accepts a variable number of arguments of which can be:
>> -    * string
>> -    * a sequences of strings (tuple or list).
>> -    * a callable object taking no parameters and returning a string or sequence of strings.
>> -    '''
>> -    head = '<html>\n  <head>\n    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>\n  </head>\n  <body>\n'
>> -    tail = '\n  </body>\n</html>'
>> -
>> -    doc = head
>> -
>> -    for body_component in body_components:
>> -        if type(body_component) is StringTypes:
>> -            doc += body_component
>> -        elif type(body_component) in [TupleType, ListType]:
>> -            for item in body_component:
>> -                doc += item
>> -        elif callable(body_component):
>> -            result = body_component()
>> -            if type(result) in [TupleType, ListType]:
>> -                for item in result:
>> -                    doc += item
>> -            else:
>> -                doc += result
>> -        else:
>> -            doc += body_component
>> -
>> -    doc += tail
>> -    return doc
